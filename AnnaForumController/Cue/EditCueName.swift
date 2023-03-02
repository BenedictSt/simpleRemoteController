//
//  EditCueName.swift
//  
//
//  Created by Benedict on 02.03.23.
//

import SwiftUI

struct EditCueName: View {
	@State var edit = false
	@State var text: String
	let setName: (String) -> Void

	init(name: String, save: @escaping (String) -> Void) {
		self.text = name
		setName = save
	}

	var body: some View {
		HStack {
			if edit {
				TextField("", text: $text)
					.font(.title)
					.textFieldStyle(.roundedBorder)
					.onChange(of: text) { _ in
						setName(text)
					}
			} else {
				Text(text)
					.font(.title)
					.onLongPressGesture {
						edit = true
					}
				Spacer()
			}

			Button(action: {
				edit.toggle()
			}) {
				Image(systemName: edit ? "checkmark" : "pencil")
					.font(.title)
			}
		}
	}
}

struct EditCueName_Previews: PreviewProvider {
	static var previews: some View {
		EditCueName(name: "Testname", save: {_ in})
	}
}
