//
//  ContentView.swift
//
//
//  Created by Benedict on 20.02.23.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		VStack(spacing: 30) {
			Image(systemName: "globe")
				.imageScale(.large)
				.foregroundColor(.accentColor)

			SoundView()

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
