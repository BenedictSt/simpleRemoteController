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

	var view: any View { get }
}

struct CueConfig {
	var cues: [any CueItem]
}

struct CueConfigWrapper {
	var cues: [CueItemWrapper]
}
