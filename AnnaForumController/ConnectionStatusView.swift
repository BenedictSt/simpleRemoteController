//
//  ConnectionStatusView.swift
//  
//
//  Created by Benedict on 24.02.23.
//

import SwiftUI
import Stripes

struct ConnectionStatusView: View {
	@ObservedObject var status: X32.Status

	init(x32: X32) {
		self.status = x32.status
	}

	var body: some View {
		VStack {
			let color: Color = status.dropped == 0 ? .green : status.dropped <= 16 ? .orange : .red
			HStack {
				Image(systemName: status.dropped == 0 ? "dot.radiowaves.up.forward" : status.dropped <= 16 || status.connected ? "wifi.exclamationmark" : "wifi.slash")
					.font(.title3)
				Text("X32:")
					.font(.headline)
				Text(status.connected ? status.dropped <= 16 ? "Verbunden" : "Aufbau..." : "Suche...")
				if status.dropped != 0 {
					Text("(verloren: \(status.dropped))")
						.font(.callout.monospacedDigit())
				}
				Spacer()
			}
			.padding()
			.background(Stripes(config: StripesConfig(background: color,
													  foreground: Color.white.opacity(0.2),
											 degrees: 45,
											 barWidth: 5,
											 barSpacing: 5)))
			.cornerRadius(10)
			.shadow(color: color, radius: 4)
		}
	}
}
