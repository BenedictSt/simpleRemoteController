//
//  ContentView.swift
//
//
//  Created by Benedict on 20.02.23.
//

import SwiftUI

struct ContentView: View {
	@State var showSettings = false

	@ObservedObject var x32 = X32()

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

			SoundView(x32: x32)
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
