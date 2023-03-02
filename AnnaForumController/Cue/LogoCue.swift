//
//  LogoCue.swift
//  
//
//  Created by Benedict on 01.03.23.
//

import Foundation
import SwiftUI

fileprivate struct Cue_Logo_View: View {
	let data: Cue_Logo

	@State private var uhrzeit = Date().formatted("HH:mm")
	let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

	var body: some View {
		GeometryReader { reader in
			ZStack {
				let gradient = Gradient(colors: [.defaultThemeColorGradient2, .defaultThemeColor])
				LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)

				VStack {
					Image("logo")
						.resizable()
						.scaledToFit()
						.frame(width: reader.size.width * 0.8, height: reader.size.height * 0.8)

					if data.zeigeUhrzeit || data.zeigeDatum {
						HStack(spacing: 20) {
							Spacer()

							if data.zeigeDatum {
								Text(Date().formatted("dd.MMM.YYYY"))
									.font(.system(size: 500))
									.frame(height: reader.size.height * 0.1)
									.minimumScaleFactor(0.01)
							}

							if data.zeigeUhrzeit {
								Text(uhrzeit)
									//.font(.largeTitle)
									.font(.system(size: 500))
									.frame(height: reader.size.height * 0.1)
									.minimumScaleFactor(0.01)
									.onReceive(timer) { _ in
										uhrzeit = Date().formatted("HH:mm")
									}
							}

							Spacer()
						}
					}
				}
			}
		}
	}
}

class Cue_Logo: CueItem {
	static func == (lhs: Cue_Logo, rhs: Cue_Logo) -> Bool {
		lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}


	let id: UUID = UUID()
	var name: String
	let type: CueType = .logo

	//config
	var zeigeUhrzeit: Bool
	var zeigeDatum: Bool

	required init() {
		name = "Schullogo"
		zeigeDatum = true
		zeigeUhrzeit = true
	}

	required init(cueItemWrapper: CueItemWrapper) {
		fatalError("todo")
	}

	var wrapper: CueItemWrapper {
		fatalError("todo")
	}

	var external_view: AnyView {
		AnyView(Cue_Logo_View(data: self))
	}

	var edit_view: AnyView {
		AnyView(Cue_Logo_View(data: self))
	}
}
