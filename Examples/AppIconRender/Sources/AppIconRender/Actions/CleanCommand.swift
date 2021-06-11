import SwishKit

struct CleanCommand: Command {
  init?() {
    guard Config.rootRendersDirectory.exists else {
      return nil
    }
  }
  
  func execute() throws {
    try Config.rootRendersDirectory.delete()
  }
}
