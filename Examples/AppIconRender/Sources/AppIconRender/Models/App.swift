enum App {
    case appstore
    case alpha

    var name: String {
        switch self {
            case .appstore: return "AppStore"
            case .alpha: return "Alpha"
        }
    }
}