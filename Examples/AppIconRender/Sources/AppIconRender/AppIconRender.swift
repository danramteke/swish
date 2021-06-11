import ArgumentParser
import SwishKit

struct AppIconRender: ParsableCommand {
	@Argument(help: "which action to run. Available actions: \(AppIconRenderTarget.allCases.map { $0.rawValue }.joined(separator: ", "))")
	var actionID: AppIconRenderTarget

	@Flag(name: .shortAndLong, help: "run the task, even if its requirements imply it doesn't need to run")
	var force: Bool = false

	func run() throws {
		try resolve(actionID, force: force)
	}
}

enum AppIconRenderTarget: String, CaseIterable, ExpressibleByArgument, Target {

	case mvgs // render mvgs - text-based scripts that ImageMagick can read to render images
	case icons // render the mvgs to pngs
	case alpha // duplicate the app icons, and place an alpha water mark on them
	case all // render icons and alpha
	case clean // clean rendered files

	var dependsOn: [Self] {
		switch self {
		case .mvgs:
			return []
		case .icons:
			return [.mvgs]
		case .alpha:
			return [.icons]
		case .all:
			return [.icons, .alpha]
		case .clean:
			return []
		}
	}

	var command: RequirableCommand {
		switch self {
		case .mvgs:
			return MvgsCommand()
		case .icons:
			return IconsCommand()
		case .alpha:
			return AlphaCommand()
		case .all:
			return AllCommand()
		case .clean:
			return CleanCommand()
		}
	}
}
