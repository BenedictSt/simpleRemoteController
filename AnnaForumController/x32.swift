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

	class Channel: ObservableObject {
		let name: String
		let id: String
		@Published var muted: Bool
		@Published var faderValue: Float

		init(name: String, id: String) {
			self.name = name
			self.id = id
			self.muted = true
			self.faderValue = 0.75
		}
	}

	@Published var updateId = UUID()

	var state: ConnectionState
	var channels: [Channel]


	init() {
		connection = OSCConnection(port: 9000)
		state = .disconnected
		channels = [
			Channel(name: "Mic 1 (blau)", id: "01"),
			Channel(name: "Mic 2 (ohne)", id: "02"),
			Channel(name: "Headset", id: "04"),
			Channel(name: "Apple TV", id: "15")
		]
	}
}
