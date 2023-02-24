//
//  OSC_Client.swift
//  
//
//  Created by Benedict on 22.02.23.
//

import Foundation
import CocoaAsyncSocket

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
