//
//  CueListView.swift
//  
//
//  Created by Benedict on 01.03.23.
//

import SwiftUI

struct CueListView: View {
	@ObservedObject var cueConfig = currentCueConfig

	var body: some View {
		VStack {
			Text("Cue List")

			ForEach((0..<cueConfig.cues.count), id: \.self) { cueIndex in

				HStack {
					if cueIndex == cueConfig.index {
						Image(systemName: "arrowtriangle.forward.fill")
					}
					Text(cueConfig.cues[cueIndex].name)
				}
				
			}

		}
	}
}

struct CueListView_Previews: PreviewProvider {
	static var previews: some View {
		CueListView()
	}
}
