import MPath
import SwishKit

struct IconsCommand: Command {

    var inputs: [Path] { filenames.map { Config.mvgRendersDirectory + Path($0.mvg) } }
    var outputs: [Path] { filenames.map { Config.appStoreIconRendersDirectory + Path($0.png) } }

    var filenames: [IconFilename] {
        IconFilename.allFilenames(for: .appstore)
    }

  init?() {
    guard FileModifiedHelper(inputs: inputs, outputs: outputs).isOutdated() else {
      return nil
    }
  }

    func execute() throws {
        try Config.appStoreIconRendersDirectory.createDirectories()
        for filename in filenames {
            let input = Config.mvgRendersDirectory + Path(filename.mvg)
            let output = Config.appStoreIconRendersDirectory + Path(filename.png)
            try sh("convert mvg:\(input.path) \(output.path)")
        }
    }
}
