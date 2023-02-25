//
//  ConnectionStatusView.swift
//  
//
//  Created by Benedict on 24.02.23.
//

import SwiftUI

struct ConnectionStatusView: View {
	@ObservedObject var status: X32.Status

	init(x32: X32) {
		self.status = x32.status
	}

	var body: some View {
		VStack {
			Text(status.connected ? "verbunden" : "suche")
			Text("dropped: \(status.dropped)")
		}
	}
}
