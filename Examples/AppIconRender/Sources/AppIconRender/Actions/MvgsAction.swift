import MPath

struct MvgsAction: Action {

    let id: ActionID = .mvgs
    let inputs: [Path] = []
    var outputs: [Path] {
        filenames.map(renderPath(for:))
    }

    var filenames: [IconFilename] {
        IconFilename.allFilenames(for: app)
    }

    func renderPath(for filename: IconFilename) -> Path {
        Config.mvgRendersDirectory + Path(filename.mvg)
    }

    let app: App = .appstore

    var dependsOn: [ActionID] { [] }

    func execute() throws {
        try Config.mvgRendersDirectory.createDirectories()

        let filenames = IconFilename.allFilenames(for: app)
        for filename in filenames {
            let renderedTemplate = MvgTemplate(edge: filename.size.baseWidth).render()
            try renderedTemplate.write(to: renderPath(for: filename))
        }
    }
}
