
enum AppIconRender: String, CaseIterable {
    case icons // render the mvg to app icon sizes
    case alpha // duplicate the app icons, and place an alpha water mark on them
    case render // render icons and alpha
    case force // render everything, even if requirements are met
    case clean // clean rendered files
}

extension AppIconRender {
    func execute() throws {
        print("running", self.rawValue)
    }
}
