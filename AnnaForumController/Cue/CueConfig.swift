//
//  CueConfig.swift
//  
//
//  Created by Benedict on 01.03.23.
//

import Foundation
import SwiftUI

enum CueType: Codable{
	case logo, text, bild, lied
}

struct CueItemWrapper: Codable, Equatable {
	var name: String
	var type: CueType
	var data: Data
}


protocol CueItem: Hashable, ObservableObject {
	var id: UUID { get }
	var name: String {get set}
	var type: CueType { get }

	init(cueItemWrapper: CueItemWrapper)
	init()
	var wrapper: CueItemWrapper { get }

	var external_view: AnyView { get }
	var edit_view: AnyView { get }
}

class CueConfig: ObservableObject{
	@Published var cues: [any CueItem] = [Cue_Logo(), Cue_Image(), Cue_Logo(), Cue_Logo()]
	@Published var index: Int = 0

	func insert(cue: any CueItem) {
		cues.insert(contentsOf: [cue], at: index+1)
		index += 1
	}
}

struct CueConfigWrapper {
	var cues: [CueItemWrapper]
}
