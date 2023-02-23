//
//  ContentView.swift
//
//
//  Created by Benedict on 20.02.23.
//

import SwiftUI

let x32OSC = OSCConnection(port: 9001)

struct ContentView: View {
	var body: some View {
		VStack(spacing: 30) {
			Image(systemName: "globe")
				.imageScale(.large)
				.foregroundColor(.accentColor)

			SoundView()

			Button(action: {

//				DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
					let msg = OSCMessage("/info", values: [])
						try? x32OSC.send(msg, to: "127.0.0.1", port: 10023)
						print("has send")

				print(x32OSC.exposedBindings)

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
				x32OSC.setHandler { message, timeTag in
							print(message, "with time tag:", timeTag)
						}

						try? x32OSC.start()
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
