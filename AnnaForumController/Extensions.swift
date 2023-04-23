//
//  Extensions.swift
//  
//
//  Created by Benedict on 01.03.23.
//

import Foundation

extension Collection {
	subscript (safe index: Index) -> Iterator.Element? {
		return indices.contains(index) ? self[index] : nil
   }
}
