//
//  CueControlView.swift
//  
//
//  Created by Benedict on 01.03.23.
//

import SwiftUI

struct CueControlView: View {
	@ObservedObject var cueConfig = currentCueConfig

	var body: some View {
		HStack {
			VStack {

				Text("Beamer:")
				let cueView = cueConfig.cues[safe: cueConfig.index]?.view ?? AnyView(Color.gray)
				cueView
					.frame(width: 400, height: 200)

				Text("nächste:")
				let nextView = cueConfig.cues[safe: cueConfig.index + 1]?.view ?? AnyView(Color.gray)
				nextView
					.frame(width: 400, height: 200)

				Button(action: {
					cueConfig.index += 1
				}) {
					Text("weiter")
				}

				Button(action: {
					cueConfig.index -= 1
				}) {
					Text("zurück")
				}

			}

			CueListView()
		}
	}
}

struct CueControlView_Previews: PreviewProvider {
	static var previews: some View {
		CueControlView()
	}
}
