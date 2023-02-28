//
//  ContentView.swift
//
//
//  Created by Benedict on 20.02.23.
//

import SwiftUI
import Stripes

struct ContentView: View {
	@State var showSettings = false

	@ObservedObject var x32: X32
	@ObservedObject var status: X32.Status

	init() {
		self.showSettings = false
		let x32Tmp = X32()
		self.x32 = x32Tmp
		self.status = x32Tmp.status
	}

	var body: some View {
		VStack(spacing: 20) {
			HStack {
				Button(action: {
					showSettings.toggle()
				}) {
					HStack {
						Spacer()
						Image(systemName: "wrench.and.screwdriver.fill")
							.imageScale(.large)
							.foregroundColor(.accentColor)
					}
				}
			}

			ConnectionStatusView(x32: x32)
				.padding(.horizontal)

			LightView(active: true, SliderValue: 0.75)
				.padding()
				.disabled(!status.connected)
				.overlay {
					if false {
						UnverbundenOverlay()
					}
				}

			SoundView(x32: x32)
				.disabled(!status.connected)
				.overlay {
					if !status.connected {
						UnverbundenOverlay()
					}
				}

			Spacer()
		}
		.padding()
		.sheet(isPresented: $showSettings) {
			SettingsView(showSettings: $showSettings)
		}
		//		.padding()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

//Button(action: {
//	LocalNetworkPermissionService().triggerDialog()
//}) {
//	Text("access")
//}
