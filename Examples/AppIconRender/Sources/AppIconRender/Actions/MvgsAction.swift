import MPath

struct MvgsAction: FileAction {

    let id: ActionID = .mvgs
    let inputs: [Path] = []
    var outputs: [Path] {
        filenames.map(renderPath(for:))
    }

    var filenames: [IconFilename] {
        IconFilename.allFilenames(for: .appstore)
    }

    func renderPath(for filename: IconFilename) -> Path {
        Config.mvgRendersDirectory + Path(filename.mvg)
    }



    var dependsOn: [ActionID] { [] }

    func execute() throws {
        try Config.mvgRendersDirectory.createDirectories()

        for filename in filenames {
            let renderedTemplate = MvgTemplate(edge: filename.size.baseWidth).render()
            try renderedTemplate.write(to: renderPath(for: filename))
        }
    }
}
