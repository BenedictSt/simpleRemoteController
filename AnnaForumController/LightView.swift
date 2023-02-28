//
//  LightView.swift
//  
//
//  Created by Benedict on 28.02.23.
//

import SwiftUI
import Stripes

struct LightView: View {
	@State var active: Bool
	@State var SliderValue: Float

	var body: some View {
		VStack(spacing: 5){
			HStack {
				Text("Scheinwerfer")
					.font(.title2.weight(.heavy))
				Spacer()
				Button(action: {
//					channel.setMuted(active)
				}) {
					MuteButton(active: active)
				}.buttonStyle(.borderless)
			}
			HStack {
				Image(systemName: "lightbulb")
					.foregroundColor(.secondary)
				Fader(value: $SliderValue)
				Text("\(Int(SliderValue * 100))%")
					.font(.headline.monospacedDigit())
					.foregroundColor(.secondary)
			}
			Divider()
		}
	}
}

struct LightView_Previews: PreviewProvider {
	static var previews: some View {
		LightView(active: true, SliderValue: 0.75)
	}
}

fileprivate struct MuteButton: View {
	let active: Bool

	var body: some View {
		let color: Color = active ? .green : .red
		let text = active ? "AN" : "AUS"

		ZStack {
			Stripes(config: StripesConfig(background: color,
										  foreground: Color.white.opacity(0.2),
										  degrees: active ? 45 : 135,
										  barWidth: 5,
										  barSpacing: 5))
			.frame(width: 40, height: 40)
			.cornerRadius(4)
			.shadow(color: color, radius: 3)

			Text(text)
				.foregroundColor(.black)
				.font(.headline)
		}
	}
}


fileprivate struct Fader: View {
	@Binding var value: Float

	var body: some View {
		Slider(value: $value, in: (0...1)) { editing in
			if !editing {
				print("set fader")
//				channel.setFader(value)
			}
		}
	}
}
