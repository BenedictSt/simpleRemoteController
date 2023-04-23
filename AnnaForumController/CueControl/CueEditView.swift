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
		GeometryReader { reader in
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
					VStack {
						CueListView()
						NewCueView()
					}
						.frame(width: reader.size.width * 0.3)
						.padding()
					let cueEditView = cueConfig.cues[safe: cueConfig.index]?.edit_view ?? AnyView(Color.gray)
					cueEditView
				}
				.id(cueConfig.index)
			}
		}
	}
}
