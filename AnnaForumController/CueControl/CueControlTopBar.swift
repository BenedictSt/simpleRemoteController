//
//  CueControlTopBar.swift
//  
//
//  Created by Benedict on 01.03.23.
//

import SwiftUI

extension Date {
	func formatted(_ format: String) -> String {
		let df = DateFormatter()
		df.dateFormat = format
		df.locale = Locale(identifier: "de_DE")

		return df.string(from: self)
	}
}

struct CueControlTopBar: View {

	@State var isTimerRunning = false
	@State private var uhrzeit = "00:00"
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

	var body: some View {
		Text(uhrzeit)
			.font(.body.monospacedDigit())
			.onReceive(timer) { _ in
				uhrzeit = Date().formatted("dd.MMM yy, HH:mm:ss")
			}
	}
}

struct CueControlTopBar_Previews: PreviewProvider {
	static var previews: some View {
		CueControlTopBar()
	}
}
