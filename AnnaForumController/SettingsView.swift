//
//  SettingsView.swift
//  
//
//  Created by Benedict on 24.02.23.
//

import SwiftUI

struct SettingsView: View {
	@Binding var showSettings: Bool

	@State var x32_hostAdress: String = ""
	@State var lampy_hostAdress: String = ""

	var body: some View {
		VStack (alignment: .leading){
			HStack {
				Text("Einstellungen")
					.font(.largeTitle.bold())
				Spacer()

				Button(action: {
					showSettings = false
				}) {
					Text("Fertig")
						.foregroundColor(.accentColor)
				}
			}

			ScrollView {
				VStack (alignment: .leading){
					HStack {
						Text("X32 Host-Adresse")
							.font(.headline)
							.padding(.top, 20)
						Text("Port: 10023")
							.font(.callout.monospacedDigit())
							.padding(.top, 20)
					}
					TextField("", text: $x32_hostAdress)
						.textFieldStyle(.roundedBorder)
						.font(.body.monospacedDigit())

					HStack {
						Text("Lampy Host-Adresse")
							.font(.headline)
							.padding(.top, 20)
						Text("Port: 8000")
							.font(.callout.monospacedDigit())
							.padding(.top, 20)
					}
					TextField("", text: $lampy_hostAdress)
						.textFieldStyle(.roundedBorder)
						.font(.body.monospacedDigit())


					Spacer()
				}
			}
		}.padding()
	}
}
