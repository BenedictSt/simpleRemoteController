//
//  AnnaForumControllerApp.swift
//  
//
//  Created by Benedict on 20.02.23.
//

import SwiftUI

class TestObserver: ObservableObject {
	@Published var x: UUID = UUID()
}

let ob = TestObserver()

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

struct testView: View {
	@ObservedObject var o = ob

	var body: some View {
		Text("\(o.x)")
	}
}

class ExtSceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	var screen: UIScreen?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		print("a")

		if session.role == .windowExternalDisplayNonInteractive {
			print("b")
			let window = UIWindow(windowScene: windowScene)
			window.rootViewController = UIViewController()

			let view = UIView(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
			let gradient = CAGradientLayer()

			gradient.frame = view.bounds
			gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]

			view.layer.insertSublayer(gradient, at: 0)

			window.addSubview(view)

//			let swiftUIView = UnverbundenOverlay()
			let swiftUIView = testView().frame(width: windowScene.screen.bounds.width, height: windowScene.screen.bounds.height).offset(x: windowScene.screen.bounds.width / 2, y: windowScene.screen.bounds.height / 2)
			let viewCtrl = UIHostingController(rootView: swiftUIView)
//			window.rootViewController?.addChild(viewCtrl)
//			viewCtrl.didMove(toParent: window.rootViewController)
			window.addSubview(viewCtrl.view)


			self.window = window

			window.makeKeyAndVisible()
			setupDisplayLinkIfNecessary()
		}
	}

	func windowScene(_ windowScene: UIWindowScene, didUpdate previousCoordinateSpace: UICoordinateSpace, interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation, traitCollection previousTraitCollection: UITraitCollection) {
		setupDisplayLinkIfNecessary()
	}

	weak var linkedScreen: UIScreen?

	func setupDisplayLinkIfNecessary() {
		let currentScreen = self.screen
		if currentScreen != linkedScreen {
			// Set up display link
			self.linkedScreen = currentScreen
		}
	}

}
