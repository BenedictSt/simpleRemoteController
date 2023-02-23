//
//  x32.swift
//  
//
//  Created by Benedict on 23.02.23.
//

import Foundation

enum ConnectionState {
	case established, connected, disconnected
}

class X32: ObservableObject{
	let connection: OSCConnection

	class Channel {
		let name: String
		unowned let x32: X32
		let id: String
		private (set) var muted: Bool
		private (set) var faderValue: Float
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
			
		}

		func setMuted(_ m: Bool) {
			let msg = OSCMessage("/ch/\(id)/mix/on", values: [muted ? 0 : 1])
			x32.send(msg)
		}

		func setFader(_ f: Float) {
			if f < 0 || f > 1 {
				print("error setting fader: out of bounds: \(f)")
			}

			let msg = OSCMessage("/ch/\(id)/mix/fader", values: [f])
			x32.send(msg)
		}
	}

	var hash: Int {
		var hasher = Hasher()
		channels.forEach({hasher.combine($0.hash)})
		return hasher.finalize()
	}

	@Published var updateId = UUID()

	var state: ConnectionState
	var channels: [Channel]


	init() {
		connection = OSCConnection(port: 9000)
		state = .disconnected
		channels = []
		channels = [
			Channel(x32: self, name: "Mic 1 (blau)", id: "01"),
			Channel(x32: self, name: "Mic 2 (ohne)", id: "02"),
			Channel(x32: self, name: "Headset", id: "04"),
			Channel(x32: self, name: "Apple TV", id: "15")
		]
	}

	func send(_ msg: OSCMessage) {
		try? x32OSC.send(msg, to: "127.0.0.1", port: 10023)
	}


	func fetch() {
		let beforeHash = hash
		channels.forEach({$0.fetch()})
		if beforeHash != hash {
			updateId = UUID()
		}
	}
}
