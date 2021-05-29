import Foundation 

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

  var decimal: Decimal {
    switch self {
    case .one: return 1
    case .two: return 2
    case .three: return 3
    }
  }
}
