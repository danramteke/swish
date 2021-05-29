import SwishKit
struct CleanAction: Action {

    func execute() throws {
        if Config.rootRendersDirectory.exists {
            try Config.rootRendersDirectory.delete()
        }
    }
}
