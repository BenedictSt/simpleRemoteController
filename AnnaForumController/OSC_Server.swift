//
//  OSC_Server.swift
//  
//
//  Created by Benedict on 22.02.23.
//

import Foundation

//
//  OSCServer.swift
//  OSCKit • https://github.com/orchetect/OSCKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//
import CocoaAsyncSocket
@_exported import OSCKitCore

/// Receives OSC packets from the network on a specific UDP listen port.
///
/// By default, a dedicated high-priority receive queue is used to receive UDP data and received OSC messages are dispatched to the main queue by way of the `handler` closure. Specific queues may be specified if needed.
///
/// > OSC 1.0 Spec:
/// >
/// > With regards OSC Bundle Time Tag:
/// >
/// > An OSC server must have access to a representation of the correct current absolute time. OSC does not provide any mechanism for clock synchronization. If the time represented by the OSC Time Tag is before or equal to the current time, the OSC Server should invoke the methods immediately. Otherwise the OSC Time Tag represents a time in the future, and the OSC server must store the OSC Bundle until the specified time and then invoke the appropriate OSC Methods. When bundles contain other bundles, the OSC Time Tag of the enclosed bundle must be greater than or equal to the OSC Time Tag of the enclosing bundle.
public final class OSCConnection: NSObject {
	let udpServer = GCDAsyncUdpSocket()
	let udpDelegate = OSCServerDelegate()
	let receiveQueue: DispatchQueue
	let dispatchQueue: DispatchQueue
	var handler: ((
		_ message: OSCMessage,
		_ timeTag: OSCTimeTag
	) -> Void)?

	/// Time tag mode. Determines how OSC bundle time tags are handled.
	public var timeTagMode: TimeTagMode

	/// UDP port used by the OSC server to listen for inbound OSC packets.
	public private(set) var port: UInt16

	public init(
		port: UInt16 = 8000,
		receiveQueue: DispatchQueue? = nil,
		dispatchQueue: DispatchQueue = .main,
		timeTagMode: TimeTagMode = .ignore,
		handler: ((
			_ message: OSCMessage,
			_ timeTag: OSCTimeTag
		) -> Void)? = nil
	) {
		self.port = port
		self.timeTagMode = timeTagMode

		self.receiveQueue = receiveQueue ?? DispatchQueue(
			label: "OSCServer",
			qos: .userInitiated
		)
		self.dispatchQueue = dispatchQueue
		self.handler = handler

		super.init()

		udpDelegate.oscServer = self
		udpServer.setDelegateQueue(self.receiveQueue)
		udpServer.setDelegate(udpDelegate)
	}

	deinit {
		stop()
	}

	/// Set the handler closure. This closure will be called when OSC bundles or messages are received. The handler is called on the `dispatchQueue` queue specified at time of initialization.
	public func setHandler(
		_ handler: @escaping (
			_ message: OSCMessage,
			_ timeTag: OSCTimeTag
		) -> Void
	) {
		self.handler = handler
	}
}

// MARK: - Lifecycle

extension OSCConnection {
	/// Bind the OSC server's local UDP port and begin listening for data.
	public func start() throws {
		stop()

		try udpServer.enableReusePort(true)
		try udpServer.bind(toPort: port)
		try udpServer.beginReceiving()
	}

	/// Stops listening for data and closes the OSC server port.
	public func stop() {
		udpServer.close()
	}
}

// MARK: - Handle and Dispatch

extension OSCConnection {
	/// Handle incoming OSC data recursively.
	func handle(
		payload: any OSCObject,
		timeTag: OSCTimeTag = .immediate()
	) throws {
		switch payload {
		case let bundle as OSCBundle:
			for element in bundle.elements {
				try handle(payload: element, timeTag: bundle.timeTag)
			}

		case let message as OSCMessage:
			schedule(message, at: timeTag)

		default:
			assertionFailure("Unexpected OSCObject type encountered.")
		}
	}

	func schedule(
		_ message: OSCMessage,
		at timeTag: OSCTimeTag = .immediate()
	) {
		switch timeTagMode {
		case .ignore:
			dispatch(message, timeTag: timeTag)

		case .osc1_0:
			// TimeTag of 1 has special meaning in OSC to dispatch "now".
			if timeTag.isImmediate {
				dispatch(message, timeTag: timeTag)
				return
			}

			// If Time Tag is <= now, dispatch immediately.
			// Otherwise, schedule message for future dispatch.
			guard timeTag.isFuture else {
				dispatch(message, timeTag: timeTag)
				return
			}

			let secondsFromNow = timeTag.timeIntervalSinceNow()
			dispatch(message, timeTag: timeTag, at: secondsFromNow)
		}
	}

	func dispatch(_ message: OSCMessage, timeTag: OSCTimeTag) {
		dispatchQueue.async {
			self.handler?(message, timeTag)
		}
	}

	func dispatch(
		_ message: OSCMessage,
		timeTag: OSCTimeTag,
		at secondsFromNow: TimeInterval
	) {
		dispatchQueue.asyncAfter(
			deadline: .now() + secondsFromNow
		) { [weak self] in
			self?.handler?(message, timeTag)
		}
	}
}

// MARK: - Internal

/// Internal UDP receiver class so as to not expose `GCDAsyncUdpSocketDelegate` methods as public on `OSCServer`.
class OSCServerDelegate: NSObject, GCDAsyncUdpSocketDelegate {
	weak var oscServer: OSCConnection?

	init(oscServer: OSCConnection? = nil) {
		self.oscServer = oscServer
	}

	/// CocoaAsyncSocket receive delegate method implementation.
	func udpSocket(
		_ sock: GCDAsyncUdpSocket,
		didReceive data: Data,
		fromAddress address: Data,
		withFilterContext filterContext: Any?
	) {
		guard let payload = try? data.parseOSC() else { return }
		try? oscServer?.handle(payload: payload)
	}
}

//
//  TimeTagMode.swift
//  OSCKit • https://github.com/orchetect/OSCKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import Foundation

extension OSCConnection {
	/// Specifies the OSCServer's time tag behavior.
	///
	/// Time tag information is not altered; this simply dictates how the server reacts to time tag information.
	public enum TimeTagMode {
		/// Adopt OSC 1.0 spec behavior where time tags may be used to schedule received OSC bundles to be dispatched at a future time.
		case osc1_0

		/// Ignore time tags present in OSC bundles.
		/// All received OSC bundles are handled immediately when received and no scheduling will occur.
		///
		/// According to the OSC 1.1 spec:
		///
		/// "We also have discovered that the OSC 1.0 semantics are not very useful for the common case of unidirectional OSC messaging. This is because the sender of OSC messages cannot know how far ahead in time to schedule OSC messages because it cannot learn of the network latency statistics seen by the receiver.
		///
		/// Instead of outlawing [common implementations by the OSC community] or other future scenarios we have decided to embrace all of them by simply not specifying time tag semantics at all in OSC 1.1. The specification simply provides a place in the stream for a time-tag, defines units for it and we still require that the least significant bit is reserved to mean 'immediately'."
		case ignore
	}
}
