import ArgumentParser

struct AppIconRender: ParsableCommand {
    @Argument(help: "which action to run. Available actions: \(ActionID.allCases.map { $0.rawValue }.joined(separator: ", "))")
    var actionID: ActionID

    @Flag(name: .shortAndLong, help: "run the task, even if its requirements imply it doesn't need to run")
    var force: Bool = false

    func run() throws {
        actionID.run(force: force)
    }
}

enum ActionID: String, CaseIterable, ExpressibleByArgument {
    case icons // render the mvg to app icon sizes
    case alpha // duplicate the app icons, and place an alpha water mark on them
    case render // render icons and alpha
    case clean // clean rendered files
    
    func run(force: Bool) {
        print("running", self.rawValue)
        if force {
            print("with force")
        }
    }
}
