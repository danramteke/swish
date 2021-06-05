import SwiftUI

@main
struct ExampleApp: App {
	var body: some Scene {

		WindowGroup { () -> AnyView in
			switch Env.current {
			case .appstore:
				return AnyView(content)
			#if DEBUG
			case .dev:
				return AnyView(content)
			case .unittest:
				return AnyView(EmptyView())
			#endif
			}
		}
	}

	private var content: some View {
		Text("\(Env.current.rawValue)")
	}
}
