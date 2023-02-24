//
//  ContentView.swift
//
//
//  Created by Benedict on 20.02.23.
//

import SwiftUI

struct ContentView: View {
	@State var showSettings = false
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
			}.padding()
			SoundView()
			Spacer()
		}.sheet(isPresented: $showSettings) {
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
