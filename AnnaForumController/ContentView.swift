//
//  ContentView.swift
//
//
//  Created by Benedict on 20.02.23.
//

import SwiftUI
import OSCKit
let oscClient = OSCClient()
let oscServer = OSCServer(port: 53001)

struct ContentView: View {
	var body: some View {
		VStack(spacing: 30) {
			Image(systemName: "globe")
				.imageScale(.large)
				.foregroundColor(.accentColor)

			SoundView()

			Button(action: {

//				DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
					let msg = OSCMessage("/version", values: [])
						try? oscClient.send(msg, to: "10.0.0.37", port: 53000)
						print("has send")

//				try? oscClient.send(
//					.message("/some/address/methodB", values: ["Test string", 123]),
//					to: "10.0.0.37", // IP address or hostname
//					port: 53000 // standard OSC port but can be changed
//				)
			}) {
				Text("Test")
			}


			Button(action: {
				print("start listening")
				oscServer.setHandler { message, timeTag in
							print(message, "with time tag:", timeTag)
						}

						try? oscServer.start()
			}) {
				Text("start listening")
			}

		Button(action: {
			LocalNetworkPermissionService().triggerDialog()
		}) {
			Text("access")
		}
		}
		.padding()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
