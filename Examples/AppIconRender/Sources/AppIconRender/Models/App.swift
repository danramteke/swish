enum App {
    case appstore
    case alpha

    var filename: String {
        switch self {
            case .appstore: return "AppStore"
            case .alpha: return "Alpha"
        }
    }
}