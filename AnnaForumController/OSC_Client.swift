//
//  OSC_Client.swift
//  
//
//  Created by Benedict on 22.02.23.
//

import Foundation

//
//  OSCClient.swift
//  OSCKit • https://github.com/orchetect/OSCKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import CocoaAsyncSocket

/// Sends OSC packets over the network ad-hoc to recipients.
///
/// A single client can serve the needs of an entire application. The client is capable of sending packets to arbitrary recipients and is not intrinsically bound to any single destination.
public final class OSCClient: NSObject {
	private let udpClient = GCDAsyncUdpSocket()

	init(port: UInt16 = 8000) {
		print("init Client")
		print(self.udpClient)
		do {
			try udpClient.enableReusePort(true)
			try udpClient.bind(toPort: port)
		} catch {
			print("could not bind client to port: \(port)")
			print(error)
		}
	}

	deinit {
		udpClient.close()
	}

	/// Send an OSC bundle or message ad-hoc to a recipient on the network.
	public func send(
		_ oscObject: any OSCObject,
		to host: String,
		port: UInt16 = 8000
	) throws {
		let data = try oscObject.rawData()

		udpClient.send(
			data,
			toHost: host,
			port: port,
			withTimeout: 1.0,
			tag: 0
		)
	}
}


extension OSCConnection {
	/// Send an OSC bundle or message ad-hoc to a recipient on the network.
	public func send(
		_ oscObject: any OSCObject,
		to host: String,
		port: UInt16 = 8000
	) throws {
		let data = try oscObject.rawData()

		udpServer.send(
			data,
			toHost: host,
			port: port,
			withTimeout: 1.0,
			tag: 0
		)
	}
}
