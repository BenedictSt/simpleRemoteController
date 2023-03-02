//
//  CueEditView.swift
//  
//
//  Created by Benedict on 01.03.23.
//

import SwiftUI

struct CueEditView: View {
	@Binding var editCueConfig: Bool

	@ObservedObject var cueConfig = currentCueConfig

	var body: some View {
		VStack {
			HStack {
				Spacer()
				Button(action: {
					editCueConfig.toggle()
				}) {
					Text("Speichern")
				}
			}

			HStack {
				CueListView()
				let cueEditView = cueConfig.cues[safe: cueConfig.index]?.edit_view ?? AnyView(Color.gray)
				cueEditView
			}
		}
	}
}
