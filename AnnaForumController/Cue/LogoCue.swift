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

	var body: some View {
		Color.blue
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

	var view: AnyView {
		AnyView(Cue_Logo_View(data: self))
	}
}
