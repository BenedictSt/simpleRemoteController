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
			VStack {
				HStack {
					Text("Folien Übersicht")
						.font(.title2)
					Spacer()
				}

				ScrollView {
					VStack {

						ForEach((0..<cueConfig.cues.count), id: \.self) { cueIndex in
							let selected = cueConfig.index == cueIndex

							HStack(spacing: 3){
								let cueView = cueConfig.cues[cueIndex].external_view

								cueView
									.frame(width: 320, height: 160)
									.cornerRadius(20)
									.scaleEffect(0.25)
									.frame(width: 80, height: 45)
									.padding(.leading, 5)

								Text(cueConfig.cues[cueIndex].name)
									.foregroundColor(selected ? .white : .primary)
								Spacer()
							}
							.background(
								selected ?
								Color.accentColor.cornerRadius(10) : Color.clear.cornerRadius(0)
							)
							.onTapGesture {
								cueConfig.index = cueIndex
							}

							Divider()

						}
						Spacer()
					}
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
