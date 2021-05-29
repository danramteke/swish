import ArgumentParser
import SwishKit

struct AppIconRender: ParsableCommand {
    @Argument(help: "which action to run. Available actions: \(AppIconRenderActionID.allCases.map { $0.rawValue }.joined(separator: ", "))")
    var actionID: AppIconRenderActionID

    @Flag(name: .shortAndLong, help: "run the task, even if its requirements imply it doesn't need to run")
    var force: Bool = false

    func run() throws {
        try actionID.action.resolve(force: force)
    }
}

enum AppIconRenderActionID: String, CaseIterable, ExpressibleByArgument, ActionID {
    case mvgs // render mvgs - text-based scripts that ImageMagick can read to render images 
    case icons // render the mvgs to pngs
    case alpha // duplicate the app icons, and place an alpha water mark on them
    case all // render icons and alpha
    case clean // clean rendered files

    var action: Action {
        switch self {
        case .mvgs:
            return MvgsAction()
        case .icons:
            return IconsAction()
        case .alpha:
            return AlphaAction()
        case .all:
            return AllAction()
        case .clean:
            return CleanAction()
        }
    }
}
