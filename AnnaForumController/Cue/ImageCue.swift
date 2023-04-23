//
//  ImageCue.swift
//  
//
//  Created by Benedict on 02.03.23.
//

import Foundation
import SwiftUI

fileprivate struct Cue_Image_View: View {
	@ObservedObject var data: Cue_Image


	var body: some View {
		GeometryReader { reader in
			if let image = data.image {
				Image(uiImage: image)
					.resizable()
					.scaledToFit()
					.frame(width: reader.size.width, height: reader.size.height)

			} else {
				Color.gray
			}
		}
	}
}

struct ImagePicker: UIViewControllerRepresentable {

	@Environment(\.presentationMode)
	private var presentationMode

	let sourceType: UIImagePickerController.SourceType
	let onImagePicked: (UIImage) -> Void

	final class Coordinator: NSObject,
	UINavigationControllerDelegate,
	UIImagePickerControllerDelegate {

		@Binding
		private var presentationMode: PresentationMode
		private let sourceType: UIImagePickerController.SourceType
		private let onImagePicked: (UIImage) -> Void

		init(presentationMode: Binding<PresentationMode>,
			 sourceType: UIImagePickerController.SourceType,
			 onImagePicked: @escaping (UIImage) -> Void) {
			_presentationMode = presentationMode
			self.sourceType = sourceType
			self.onImagePicked = onImagePicked
		}

		func imagePickerController(_ picker: UIImagePickerController,
								   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
			let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
			onImagePicked(uiImage)
			presentationMode.dismiss()

		}

		func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
			presentationMode.dismiss()
		}

	}

	func makeCoordinator() -> Coordinator {
		return Coordinator(presentationMode: presentationMode,
						   sourceType: sourceType,
						   onImagePicked: onImagePicked)
	}

	func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
		let picker = UIImagePickerController()
		picker.sourceType = sourceType
		picker.delegate = context.coordinator
		return picker
	}

	func updateUIViewController(_ uiViewController: UIImagePickerController,
								context: UIViewControllerRepresentableContext<ImagePicker>) {

	}

}

fileprivate struct Cue_Image_Edit_View: View {
	@ObservedObject var data: Cue_Image

	@State var showImagePicker: Bool = false

	init(data: Cue_Image) {
		self.data = data

	}

	var body: some View {
		VStack {
			EditCueName(name: data.name, save: {data.name = $0})


			Cue_Image_View(data: data)
				.frame(width: 400, height: 350)
				.fixedSize()

			Button(action: {
				showImagePicker.toggle()
			}) {
				Text("Bild auswählen")
			}



		}
		.sheet(isPresented: $showImagePicker) {
						ImagePicker(sourceType: .photoLibrary) { image in
							data.image = image
						}
					}
	}
}

class Cue_Image: CueItem {
	static func == (lhs: Cue_Image, rhs: Cue_Image) -> Bool {
		lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}


	let id: UUID = UUID()
	@Published var name: String
	let type: CueType = .logo

	//config
	@Published var image: UIImage?

	required init() {
		name = "Bild"
	}

	required init(cueItemWrapper: CueItemWrapper) {
		fatalError("todo")
	}

	var wrapper: CueItemWrapper {
		fatalError("todo")
	}

	var external_view: AnyView {
		AnyView(Cue_Image_View(data: self))
	}

	var edit_view: AnyView {
		AnyView(Cue_Image_Edit_View(data: self))
	}
}
