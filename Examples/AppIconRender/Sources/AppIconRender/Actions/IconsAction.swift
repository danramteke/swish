import MPath
import SwishKit

let iconMVG: Path = "icon.mvg"
struct IconsAction: Action {
    let id: ActionID = .icons
    let inputs: [Path] = [iconMVG]
    let outputs: [Path]

    let app: App = .appstore

    // var commands: [Command] {
    //     IconSize.
    //     [
    //         cmd("convert mvg:\(iconMVG.path) ")
    //     ]
    // }

    var dependsOn: [ActionID] { [.mvgs] }

    func execute() throws {
        
    }
    //convert mvg:src/underway-icon.mvg output/underway-icon-1024.png
    // var text: String {
    //     "convert mvg:\(iconMVG.path)"
    // }
}
