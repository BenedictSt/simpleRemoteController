//
//  PanicButton.swift
//  
//
//  Created by Benedict on 24.02.23.
//

import SwiftUI
import Stripes

struct PanicButton: View {
	var body: some View {
		Button(action: {

		}) {
			HStack {
				Spacer()
				Image(systemName: "exclamationmark")
					.font(.title.bold())
					.foregroundColor(.black)
				Text("Not Aus")
					.font(.title.bold())
					.foregroundColor(.black)
				Image(systemName: "exclamationmark")
					.font(.title.bold())
					.foregroundColor(.black)
				Spacer()
			}
		}
		.frame(height: 60)
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
		PanicButton()
			.previewDevice("iPhone 14 Pro")
	}
}
