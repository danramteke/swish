import Foundation

enum IconSize: CaseIterable {
  case iPhoneNotification2x, iPhoneNotification3x
  case iPhoneSettings2x, iPhoneSettings3x
  case iPhoneSpotlight2x, iPhoneSpotlight3x
  case iPhoneApp2x, iPhoneApp3x
  case iPadNotifications, iPadNotifications2x
  case iPadSettings, iPadSettings2x
  case iPadSpotlight, iPadSpotlight2x
  case iPadApp, iPadApp2x
  case iPadPro2x
  case AppStore

  var edge: Decimal {
    self.data.pixelWidth
  }

  var data: Data {
    switch self {
      case .iPhoneNotification2x: return .iPhoneNotification2x
      case .iPhoneNotification3x: return .iPhoneNotification3x
      case .iPhoneSettings2x: return .iPhoneSettings2x
      case .iPhoneSettings3x: return .iPhoneSettings3x
      case .iPhoneSpotlight2x: return .iPhoneSpotlight2x
      case .iPhoneSpotlight3x: return .iPhoneSpotlight3x
      case .iPhoneApp2x: return .iPhoneApp2x
      case .iPhoneApp3x: return .iPhoneApp3x
      case .iPadNotifications: return .iPadNotifications
      case .iPadNotifications2x: return .iPadNotifications2x
      case .iPadSettings: return .iPadSettings
      case .iPadSettings2x: return .iPadSettings2x
      case .iPadSpotlight: return .iPadSpotlight
      case .iPadSpotlight2x: return .iPadSpotlight2x
      case .iPadApp: return .iPadApp
      case .iPadApp2x: return .iPadApp2x
      case .iPadPro2x: return .iPadPro2x
      case .AppStore: return .AppStore
    }
  }

  struct Data {
    let baseWidth: Decimal
    let scale: IconScale

    static let iPhoneNotification2x = IconSize.Data(20, .two)
    static let iPhoneNotification3x = IconSize.Data(20, .three)
    static let iPhoneSettings2x = IconSize.Data(29, .two)
    static let iPhoneSettings3x = IconSize.Data(29, .three)
    static let iPhoneSpotlight2x = IconSize.Data(40, .two)
    static let iPhoneSpotlight3x = IconSize.Data(40, .three)
    static let iPhoneApp2x = IconSize.Data(60, .two)
    static let iPhoneApp3x = IconSize.Data(60, .three)
    static let iPadNotifications = IconSize.Data(20, .one)
    static let iPadNotifications2x = IconSize.Data(20, .two)
    static let iPadSettings = IconSize.Data(29, .one)
    static let iPadSettings2x = IconSize.Data(29, .two)
    static let iPadSpotlight = IconSize.Data(40, .one)
    static let iPadSpotlight2x = IconSize.Data(40, .two)
    static let iPadApp = IconSize.Data(76, .one)
    static let iPadApp2x = IconSize.Data(76, .two)
    static let iPadPro2x = IconSize.Data(83.5, .two)
    static let AppStore = IconSize.Data(1024, .one)

    var pixelWidth: Decimal {
      switch scale {
        case .one:
          return baseWidth
        case .two:
          return baseWidth * 2
        case .three:
          return baseWidth * 3
      }
    }

    init(_ baseWidth: Decimal, _ scale: IconScale) {
      self.baseWidth = baseWidth
      self.scale = scale
    }
  }  
}

