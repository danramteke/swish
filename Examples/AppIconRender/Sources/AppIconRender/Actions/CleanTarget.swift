import SwishKit

struct CleanTarget: Target {

    func execute() throws {
        if Config.rootRendersDirectory.exists {
            try Config.rootRendersDirectory.delete()
        }
    }
}
