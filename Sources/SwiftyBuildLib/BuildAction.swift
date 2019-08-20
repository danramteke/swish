public enum BuildAction {
  case build(TargetOptions)
  case test(TargetOptions)
  case archive(TargetOptions, sdk: String, archivePath: String)
  case export(archivePath: String, exportPath: String, ExportOptions)

  var additionalRenders: String {
    switch self {
      case .archive(let targetOptions, let sdk, let archivePath): return targetOptions.rendered + "-sdk \(sdk) -archivePath \(archivePath)"
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
