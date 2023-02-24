//
//  ChannelView.swift
//  
//
//  Created by Benedict on 24.02.23.
//

import SwiftUI


fileprivate struct MuteButton: View {
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


fileprivate struct Fader: View {
	let channel: X32.Channel
	@Binding var value: Float

	var body: some View {
		Slider(value: $value, in: (0...1)) { editing in
			if !editing {
				print("set fader")
				channel.setFader(value)
			}
		}
	}
}

struct ChannelView: View {
	let channel: X32.Channel
	@State var active: Bool
	@State var SliderValue: Float

	init(channel: X32.Channel) {
		self.channel = channel
		self.active = !channel.muted
		self.SliderValue = channel.faderValue
	}

	var body: some View {
		VStack {
			HStack {
				Text(channel.name)
					.font(.title2.weight(.heavy))
				Spacer()
				Button(action: {
					channel.setMuted(active)
				}) {
					MuteButton(active: active)
				}.buttonStyle(.borderless)
			}
			HStack {
				Image(systemName: "speaker.wave.2")
					.foregroundColor(.secondary)
				Fader(channel: channel, value: $SliderValue)
				Text("\(SliderValue.dbString)db")
					.font(.headline)
					.foregroundColor(.secondary)
			}
			Divider()
		}
	}
}
