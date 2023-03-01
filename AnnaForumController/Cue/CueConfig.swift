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


protocol CueItem {
	var name: String {get set}
	var type: CueType { get }

	init(cueItemWrapper: CueItemWrapper)
	init()
	var wrapper: CueItemWrapper { get }

	var view: AnyView { get }
}

class CueConfig: ObservableObject{
	var cues: [any CueItem] = [Cue_Logo()]
	@Published var index: Int = 0
}

struct CueConfigWrapper {
	var cues: [CueItemWrapper]
}