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
		VStack(spacing: 30) {
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
				.padding()

			SoundView(x32: x32)
				.disabled(!status.connected)
				.overlay {
					if !status.connected {
						ZStack {
							Stripes(config: StripesConfig(background: .black,
														  foreground: Color.white.opacity(0.2),
														  degrees: 45,
														  barWidth: 5,
														  barSpacing: 5)).opacity(0.5)
								.cornerRadius(10)
							VStack {
								Image(systemName: "bolt.horizontal.fill")
									.font(.largeTitle)
									.foregroundColor(.white)
								Text("Nicht Verbunden")
									.font(.title.bold())
									.foregroundColor(.white)
							}
						}
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
