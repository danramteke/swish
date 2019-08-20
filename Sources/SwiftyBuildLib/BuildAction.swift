public enum BuildAction {
  case build(TargetOptions), test(TargetOptions), archive(TargetOptions), export

  var additionalRenders: String {
    switch self {
      case .archive(let targetOptions): return targetOptions.rendered
      case .build(let targetOptions): return "-destination generic/platform=iOS " + targetOptions.rendered
      case .export: return ""
      case .test(let targetOptions): return targetOptions.rendered
    }
  }

  var id: String {
    switch self {
      case .archive: return "archive"
      case .build: return "build"
      case .export: return "export"
      case .test: return "test"
    }
  }

  public func render() -> String {
    return "xcodebuild \(self.additionalRenders) \(self.id) -allowProvisioningUpdates -allowProvisioningDeviceRegistration"
  }

  public func run() throws {
    print(self.render())
  }
}

extension Array where Element == BuildAction {
  func run() throws {
    for action in self {
      try action.run()
    }
  }
}
