enum IconScale {
  case one
  case two
  case three
  
  var suffix: String {
    switch self {
    case .one: return ""
    case .two: return "@2x"
    case .three: return "@3x"
    }
  }
}
