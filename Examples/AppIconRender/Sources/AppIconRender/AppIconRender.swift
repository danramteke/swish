import ArgumentParser
import SwishKit

struct AppIconRender: ParsableCommand {
    @Argument(help: "which action to run. Available actions: \(AppIconRenderActionID.allCases.map { $0.rawValue }.joined(separator: ", "))")
    var actionID: AppIconRenderActionID

    @Flag(name: .shortAndLong, help: "run the task, even if its requirements imply it doesn't need to run")
    var force: Bool = false

    func run() throws {
        try actionID.resolve(force: force)
    }
}

enum AppIconRenderActionID: String, CaseIterable, ExpressibleByArgument, TargetID {
    case mvgs // render mvgs - text-based scripts that ImageMagick can read to render images 
    case icons // render the mvgs to pngs
    case alpha // duplicate the app icons, and place an alpha water mark on them
    case all // render icons and alpha
    case clean // clean rendered files

    var target: Target {
        switch self {
        case .mvgs:
            return MvgsTarget()
        case .icons:
            return IconsTarget()
        case .alpha:
            return AlphaTarget()
        case .all:
            return AllTarget()
        case .clean:
            return CleanTarget()
        }
    }
}
