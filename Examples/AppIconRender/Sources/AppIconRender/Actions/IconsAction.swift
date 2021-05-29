import MPath
import SwishKit


struct IconsAction: Action {
    let id: ActionID = .icons
    var inputs: [Path] { filenames.map { Path($0.mvg) } }
    var outputs: [Path] { filenames.map { Path($0.png) } }

    var filenames: [IconFilename] {
        IconFilename.allFilenames(for: .appstore)
    }

    var dependsOn: [ActionID] { [.mvgs] }

    func execute() throws {
        try Config.appStoreIconRendersDirectory.createDirectories()
        for filename in filenames {
            let input = Config.mvgRendersDirectory + Path(filename.mvg)
            let output = Config.appStoreIconRendersDirectory + Path(filename.png)
            try sh("convert mvg:\(input.path) \(output.path)")
        }
    }
}
