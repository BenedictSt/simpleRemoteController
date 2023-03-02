//
//  NewCueView.swift
//  
//
//  Created by Benedict on 02.03.23.
//

import SwiftUI

struct NewCueView: View {
	@ObservedObject var cueConfig = currentCueConfig

	var body: some View {
		Grid(horizontalSpacing: 10){
			GridRow {
				NewCueButton(name: "Logo", icon: "leaf", action: {cueConfig.insert(cue: Cue_Logo())})
				NewCueButton(name: "Bild", icon: "photo", action: {cueConfig.insert(cue: Cue_Image())})
			}
			GridRow {
				NewCueButton(name: "Skizze", icon: "scribble", action: {})
				NewCueButton(name: "Lied", icon: "textformat.123", action: {})
			}
		}
	}
}

fileprivate struct NewCueButton: View {
	let name: String
	let icon: String
	let action: () -> Void

	var body: some View {
		Button(action: {
			action()
		}) {
			HStack {
				Spacer()
				Image(systemName: icon)
					.font(.headline)
					.foregroundColor(.primary)
				Text(name)
					.font(.headline)
					.foregroundColor(.primary)
				Spacer()
			}
			.padding(.vertical)
		}
		.buttonStyle(.borderless)
		.background(Color.gray.opacity(0.7))
		.cornerRadius(20)

	}
}

struct NewCueView_Previews: PreviewProvider {
	static var previews: some View {
		NewCueView()
	}
}

//struct NewCueButton_Previews: PreviewProvider {
//	static var previews: some View {
//		NewCueButton(name: "Logo", icon: "photo", action: {})
//	}
//}
