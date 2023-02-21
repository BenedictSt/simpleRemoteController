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


struct Fader: View {
	@Binding var value: Float

	var body: some View {
		Slider(value: $value, in: (0...1))
			.frame(width: 200)
	}
}

struct MicSettings: View {
	let name: String
	@State var active: Bool
	@State var fader: Float

	var body: some View {
		HStack {
			Text(name)
				.font(.largeTitle)
				.frame(width: 200, alignment: .leading)

			Fader(value: $fader)
			Spacer()
			MuteButton(active: active)
		}
	}
}



struct SoundView: View {
	var body: some View {

		VStack {
			MicSettings(name: "Mic 1 (blau)", active: true, fader: 0.0)
			MicSettings(name: "Headset 1", active: false, fader: 0.5)
			MicSettings(name: "Apple TV", active: false, fader: 0.5)
		}.padding(49)
	}
}

struct SoundView_Previews: PreviewProvider {
	static var previews: some View {
		SoundView()
	}
}
