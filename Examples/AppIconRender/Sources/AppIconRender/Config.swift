import MPath
import SwishKit

enum Config {
    static let exampleName = "AppIconRender"
    static let gitRoot: Path = {
        try! sh("git rev-parse --show-toplevel", as: Path.self)
    }()
    
    static let rootRendersDirectory: Path = {
        gitRoot + Path("Examples") + Path(exampleName) + Path("renders")
    }()

    static let mvgRendersDirectory: Path = {
        rootRendersDirectory + Path("mvgs")
    }()

    static let appStoreIconRendersDirectory: Path = {
        rootRendersDirectory + Path("pngs") + Path("appstore")
    }()

    static let alphaIconRendersDirectory: Path = {
        rootRendersDirectory + Path("pngs") + Path("alpha")
    }()
}