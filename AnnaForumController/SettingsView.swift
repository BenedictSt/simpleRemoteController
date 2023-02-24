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
					Text("Dieses Gerät")
						.font(.headline)
						.padding(.top, 20)

					let ipAddresses = LocalNetworkPermissionService().ipv4AddressesOfEthernetLikeInterfaces()

					ForEach(ipAddresses, id: \.self) { ipAddress in
						Text("IP: \(ipAddress)")
							.font(.callout.monospaced())
					}

					Text("UDP-Port: 10000 (X32 reply)")
						.font(.callout.monospaced())


					Text("UDP-Port: 9000 (Lampy reply)")
						.font(.callout.monospaced())




					HStack {
						Text("X32 Host-Adresse")
							.font(.headline)
							.padding(.top, 20)
						Text("Port: 10023")
							.font(.callout.monospaced())
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
							.font(.callout.monospaced())
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
