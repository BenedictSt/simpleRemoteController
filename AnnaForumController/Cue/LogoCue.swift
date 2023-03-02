//
//  LogoCue.swift
//  
//
//  Created by Benedict on 01.03.23.
//

import Foundation
import SwiftUI

class CloudProvider: ObservableObject {
	let offset: CGSize
	let frameHeightRatio: CGFloat

	init() {
		frameHeightRatio = CGFloat.random(in: 0.7 ..< 1.4)
		offset = CGSize(width: CGFloat.random(in: -150 ..< 150),
						height: CGFloat.random(in: -150 ..< 150))
	}
}

struct Cloud: View {
	@StateObject var provider = CloudProvider()
	@State var move = false
	let proxy: GeometryProxy
	let color: Color
	let rotationStart: Double
	let duration: Double
	let alignment: Alignment

	var body: some View {
		Circle()
			.fill(color)
			.frame(height: proxy.size.height /  provider.frameHeightRatio)
			.offset(provider.offset)
			.rotationEffect(.init(degrees: move ? rotationStart : rotationStart + 360) )
			.animation(Animation.linear(duration: duration).repeatForever(autoreverses: false))
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
			.opacity(0.8)
			.onAppear {
				move.toggle()
			}
	}
}

struct FloatingClouds: View {
	@Environment(\.colorScheme) var scheme
	let blur: CGFloat = 50

	var body: some View {
		GeometryReader { proxy in
			ZStack {
				Color.defaultThemeColor
				ZStack {
					Cloud(proxy: proxy,
						  color: .red,
						  rotationStart: 0,
						  duration: 60,
						  alignment: .bottomTrailing)
					Cloud(proxy: proxy,
						  color: .green,
						  rotationStart: 240,
						  duration: 50,
						  alignment: .topTrailing)
					Cloud(proxy: proxy,
						  color: .blue,
						  rotationStart: 120,
						  duration: 80,
						  alignment: .bottomLeading)
					Cloud(proxy: proxy,
						  color: .purple,
						  rotationStart: 180,
						  duration: 70,
						  alignment: .topLeading)
				}
				.blur(radius: blur)
			}
			.ignoresSafeArea()
		}
	}
}

fileprivate struct Cue_Logo_View: View {
	let data: Cue_Logo

	@State private var uhrzeit = Date().formatted("HH:mm")
	let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

	var body: some View {
		GeometryReader { reader in
			ZStack {
				let gradient = Gradient(colors: [.defaultThemeColorGradient2, .defaultThemeColor])
				LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)

//				FloatingClouds()
//					.frame(width: reader.size.width, height: reader.size.height)

				VStack {
					Image("logo")
						.resizable()
						.foregroundColor(.white)
						.scaledToFit()
						.frame(width: reader.size.width * 0.8, height: reader.size.height * 0.8)

					if data.zeigeUhrzeit || data.zeigeDatum {
						HStack(spacing: 20) {
							Spacer()

							if data.zeigeDatum {
								Text(Date().formatted("dd.MMM.YYYY"))
									.font(.system(size: 500))
									.foregroundColor(.white)
									.frame(height: reader.size.height * 0.1)
									.minimumScaleFactor(0.01)
							}

							if data.zeigeUhrzeit {
								Text(uhrzeit)
									//.font(.largeTitle)
									.font(.system(size: 500))
									.foregroundColor(.white)
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

fileprivate struct Cue_Logo_Edit_View: View {
	@ObservedObject var data: Cue_Logo

	@State var zeigeDatum: Bool
	@State var zeigeUhrzeit: Bool

	init(data: Cue_Logo) {
		self.data = data
		self.zeigeDatum = data.zeigeDatum
		self.zeigeUhrzeit = data.zeigeUhrzeit
	}

	var body: some View {
		VStack {
			EditCueName(name: data.name, save: {data.name = $0})


			Cue_Logo_View(data: data)
				.frame(width: 400, height: 350)
				.fixedSize()
			Toggle("Datum anzeigen", isOn: $zeigeDatum)
				.onChange(of: zeigeDatum, perform: { _ in
					data.zeigeDatum = zeigeDatum
				})
			Toggle("Uhrzeit anzeigen", isOn: $zeigeUhrzeit)
				.onChange(of: zeigeUhrzeit, perform: { _ in
					data.zeigeUhrzeit = zeigeUhrzeit
				})

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
	@Published var name: String
	let type: CueType = .logo

	//config
	@Published var zeigeUhrzeit: Bool
	@Published var zeigeDatum: Bool

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
		AnyView(Cue_Logo_Edit_View(data: self))
	}
}
