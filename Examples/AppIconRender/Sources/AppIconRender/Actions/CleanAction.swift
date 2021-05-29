import SwishKit
struct CleanAction: Action {
    let id: ActionID = .clean
    func execute() throws {
        if Config.rootRendersDirectory.exists {
            try Config.rootRendersDirectory.delete()
        }
    }
}