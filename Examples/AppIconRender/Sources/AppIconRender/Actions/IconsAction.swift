import MPath
import SwishKit


struct IconsAction: Action {
    let id: ActionID = .icons
    let inputs: [Path] = MvgsAction().outputs
    var outputs: [Path] {
        inputs.map(outputPath(for:))
    }

    func outputPath(for inputPath: Path) -> Path {
        let components = inputPath.components
            
        let newFilename = String(components.last!.split(separator: ".")[0]) + ".png"

        return Path("/") + Path(components: components.dropLast()) + Path(newFilename)
    }

    let app: App = .appstore

    var dependsOn: [ActionID] { [.mvgs] }

    func execute() throws {
        for input in inputs {
            let outputPath = self.outputPath(for: input)
            try sh("convert mvg:\(input.path) \(outputPath.path)")
        }
    }
}
