//
//  ExternalDisplayView.swift
//  
//
//  Created by Benedict on 01.03.23.
//

import SwiftUI

struct ExternalDisplayView: View {

	@ObservedObject var cueConfig = currentCueConfig

	var body: some View {
		if let cue = cueConfig.cues[safe: cueConfig.index] {
			cue.view
		}
	}
}

struct ExternalDisplayView_Previews: PreviewProvider {
	static var previews: some View {
		ExternalDisplayView()
	}
}
