//
//  SoundView.swift
//  
//
//  Created by Benedict on 20.02.23.
//

import SwiftUI

struct SoundView: View {
	@ObservedObject var x32 = X32()
	var body: some View {
		VStack {
			PanicButton()
				.padding(.bottom, 20)
			ForEach(x32.channels, id: \.self) { channel in
				ChannelView(channel: channel)
			}
		}.padding()
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
