//
//  PanicButton.swift
//  
//
//  Created by Benedict on 24.02.23.
//

import SwiftUI
import Stripes

struct PanicButton: View {
	let x32: X32

	var body: some View {
		Button(action: {
			x32.channels.forEach({$0.setMuted(true)})
		}) {
			HStack {
				Spacer()
				Image(systemName: "exclamationmark")
					.font(.title2.bold())
					.foregroundColor(.black)
				Text("Alles Aus")
					.font(.title2.bold())
					.foregroundColor(.black)
				Image(systemName: "exclamationmark")
					.font(.title2.bold())
					.foregroundColor(.black)
				Spacer()
			}
		}
		.frame(height: 50)
		.background(Stripes(config: StripesConfig(background: .yellow,
												  foreground: Color.white.opacity(0.4), degrees: 45,
			  barWidth: 10, barSpacing: 10)))
		.cornerRadius(10)
		.shadow(color: .yellow, radius: 4)
//		.padding()
	}
}

struct PanicButton_Previews: PreviewProvider {
	static var previews: some View {
		PanicButton(x32: X32())
			.previewDevice("iPhone 14 Pro")
	}
}
