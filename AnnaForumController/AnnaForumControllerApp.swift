//
//  AnnaForumControllerApp.swift
//  
//
//  Created by Benedict on 20.02.23.
//

import SwiftUI

@main
struct AnnaForumControllerApp: App {
	var body: some Scene {
		WindowGroup {
			if UIDevice.current.userInterfaceIdiom == .phone {
				ContentView()
			} else {
				GeometryReader { reader in
					HStack {
						ContentView()
							.frame(width: reader.size.width / 3)
					}
				}
			}
		}
	}
}
