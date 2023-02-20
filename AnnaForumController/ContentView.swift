//
//  ContentView.swift
//
//
//  Created by Benedict on 20.02.23.
//

import SwiftUI
import OSCKit
let oscClient = OSCClient()

struct ContentView: View {
	var body: some View {
		VStack(spacing: 30) {
			Image(systemName: "globe")
				.imageScale(.large)
				.foregroundColor(.accentColor)
			Button(action: {

//				DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
					let msg = OSCMessage("/a", values: ["a"])
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

			}) {
				Text("2")
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
