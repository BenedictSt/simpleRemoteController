//
//  SoundView.swift
//  
//
//  Created by Benedict on 20.02.23.
//

import SwiftUI
import OSCKitCore

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
	let channel: X32.Channel
	@Binding var value: Float

	var body: some View {
		Slider(value: $value, in: (0...1)) { editing in
			if !editing {
				print("set fader")
				channel.setFader(value)
			}
		}
//			.frame(width: 200)
	}
}

struct MicSettings: View {
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
								.font(.headline)
//					.frame(width: 200, alignment: .leading)
//					.background(.blue)
				Spacer()
				Button(action: {
					channel.setMuted(active)
				}) {
					MuteButton(active: active)
				}.buttonStyle(.borderless)
			}
//			.background(.green)
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



struct SoundView: View {
	@ObservedObject var x32 = X32()
	var body: some View {
		VStack {
			ForEach(x32.channels, id: \.self) { channel in
				MicSettings(channel: channel)
			}
		}.padding(49)
			.id(x32.updateId)
			.onAppear {
				x32.startBackgroundUpdates()
			}
			.onDisappear {
				x32.stopBackgroundUpdates()
			}
	}
}

struct SoundView_Previews: PreviewProvider {
	static var previews: some View {
		SoundView()
			.previewDevice("iPhone 14 Pro")
	}
}
