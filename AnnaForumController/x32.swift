//
//  x32.swift
//  
//
//  Created by Benedict on 23.02.23.
//

import Foundation

class X32: ObservableObject{
	let connection: OSCConnection
	var updateTimer: Timer?

	class Status: ObservableObject{
		@Published var connected: Bool
		@Published var dropped: Int
		var received: [Int]
		var send: [Int]

		init() {
			connected = false
			dropped = 0
			received = [0]
			send = [0]
		}


		func tick() {
			received.append(0)
			send.append(0)
			received = Array(received.dropFirst(max(0, received.count - 20)))
			send = Array(send.dropFirst(max(0, send.count - 20)))
			connected = received.dropFirst(max(0, received.count - 4)).reduce(0, +) > 0
			dropped = max(0, send.reduce(0, +) - received.reduce(0, +))
		}

		func shouldReceiveReply() {
			if !send.isEmpty {
				send[received.count - 1] += 1
			}
		}

		func receivedReply() {
			if !received.isEmpty {
				received[received.count - 1] += 1
			}
		}

	}

	class Channel: Hashable{
		static func == (lhs: X32.Channel, rhs: X32.Channel) -> Bool {
			lhs.id == rhs.id
		}

		func hash(into hasher: inout Hasher) {
			hasher.combine(name)
			hasher.combine(id)
			hasher.combine(muted)
			hasher.combine(faderValue)
		}


		let name: String
		unowned let x32: X32

		let id: String
		var osc_on: String { "/ch/\(id)/mix/on" }
		var osc_fader: String { "/ch/\(id)/mix/fader" }

		fileprivate (set) var muted: Bool
		fileprivate (set) var faderValue: Float
		var hash: Int {
			var hasher = Hasher()
			hasher.combine(id)
			hasher.combine(muted)
			hasher.combine(faderValue)
			return hasher.finalize()
		}

		init(x32: X32, name: String, id: String) {
			self.x32 = x32
			self.name = name
			self.id = id
			self.muted = true
			self.faderValue = 0.75
		}

		func fetch() {
			x32.send(OSCMessage(osc_on, values: []))
			x32.send(OSCMessage(osc_fader, values: []))
			x32.status.shouldReceiveReply()
			x32.status.shouldReceiveReply()
		}

		func setMuted(_ m: Bool) {
			let msg = OSCMessage(osc_on, values: [m ? 0 : 1])
			x32.send(msg)
			fetch()
		}

		func setFader(_ f: Float) {
			if f < 0 || f > 1 {
				print("error setting fader: out of bounds: \(f)")
			}

			let msg = OSCMessage(osc_fader, values: [f])
			x32.send(msg)
			fetch()
		}
	}

	var hash: Int {
		var hasher = Hasher()
		channels.forEach({hasher.combine($0.hash)})
		return hasher.finalize()
	}

	@Published var updateId = UUID()
	let status: Status = Status()

	var channels: [Channel]


	init() {
		connection = OSCConnection(port: 9000 + UInt16.random(in: 0...1000))
		channels = []
		channels = [
			Channel(x32: self, name: "Mic 1 (blau)", id: "01"),
			Channel(x32: self, name: "Mic 2 (ohne)", id: "02"),
			Channel(x32: self, name: "Headset", id: "04"),
			Channel(x32: self, name: "Apple TV", id: "15")
		]

		connection.setHandler(returnHandler)
		try? connection.start()
		print("start x32 listener")
	}

	deinit {
		self.connection.stop()
		self.updateTimer?.invalidate()
		self.updateTimer = nil
	}


	func startBackgroundUpdates() {
		if let _ = updateTimer {
			return
		}
		updateTimer = Timer(timeInterval: 0.5, repeats: true, block: {_ in
			self.fetch()
		})
		RunLoop.main.add(updateTimer!, forMode: .common)
	}

	func stopBackgroundUpdates() {
		if let _ = updateTimer {
			updateTimer?.invalidate()
			updateTimer = nil
		}
	}

	func returnHandler(message: OSCMessage, timeTag: OSCTimeTag) {
		let beforeHash = hash
		status.receivedReply()
		//		print("handle: \(message.descriptionPretty)")
		do {
			for channel in channels {
				if message.addressPattern.matches(localAddress: channel.osc_on) {
					let newValue = try message.values.masked(Int?.self)
					if let newValue {
						channel.muted = newValue == 0
					}
				}

				if message.addressPattern.matches(localAddress: channel.osc_fader) {
					let newValue = try message.values.masked(Float?.self)
					if let newValue {
						channel.faderValue = newValue
					}
				}
			}
		} catch {
			print("error handling oscMessage: \(message.descriptionPretty)")
		}
		if beforeHash != hash {
			updateId = UUID()
		}
	}

	func send(_ msg: OSCMessage) {
		try? connection.send(msg, to: "127.0.0.1", port: 10023)
	}


	func fetch() {
		status.tick()
		channels.forEach({$0.fetch()})
	}
}
