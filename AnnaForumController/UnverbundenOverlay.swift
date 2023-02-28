//
//  UnverbundenOverlay.swift
//  
//
//  Created by Benedict on 28.02.23.
//

import SwiftUI
import Stripes

struct UnverbundenOverlay: View {
	var body: some View {
		ZStack {
			Stripes(config: StripesConfig(background: .black,
										  foreground: Color.white.opacity(0.2),
										  degrees: 45,
										  barWidth: 5,
										  barSpacing: 5)).opacity(0.5)
				.cornerRadius(10)
			VStack {
				Image(systemName: "bolt.horizontal.fill")
					.font(.largeTitle)
					.foregroundColor(.white)
				Text("Nicht Verbunden")
					.font(.title.bold())
					.foregroundColor(.white)
			}
		}
	}
}

struct UnverbundenOverlay_Previews: PreviewProvider {
	static var previews: some View {
		UnverbundenOverlay()
	}
}
