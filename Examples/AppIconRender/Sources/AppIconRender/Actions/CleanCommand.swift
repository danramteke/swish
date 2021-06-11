import SwishKit

struct CleanCommand: RequirableCommand {

    func execute() throws {
        if Config.rootRendersDirectory.exists {
            try Config.rootRendersDirectory.delete()
        }
    }
}
