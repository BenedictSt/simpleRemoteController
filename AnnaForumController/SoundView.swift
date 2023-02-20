//
//  SoundView.swift
//  
//
//  Created by Benedict on 20.02.23.
//

import SwiftUI

struct MuteButton: View {
	let active: Bool

	var body: some View {
		let color: Color = active ? .green : .red
		let text = active ? "AN" : "AUS"

		ZStack {
			Rectangle()
				.foregroundColor(color)
				.frame(width: 40, height: 40)
				.cornerRadius(4)
				.shadow(color: color, radius: 3)

			Text(text)
				.foregroundColor(.black)
				.font(.headline)
		}
	}
}





struct SoundView: View {
	var body: some View {
		VStack {
			MuteButton(active: true)
			MuteButton(active: false)
		}.padding(49)
	}
}

struct SoundView_Previews: PreviewProvider {
	static var previews: some View {
		SoundView()
	}
}
