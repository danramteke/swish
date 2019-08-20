public enum BuildAction: String {
  case build, test, archive, export

  var additionalRenders: String {
    switch self {
      case .archive: return ""
      case .build: return "-destination generic/platform=iOS"
      case .export: return ""
      case .test: return ""
    }
  }

  public func render(options: ProjectOptions) -> String {
    return "xcodebuild \(options.rendered) \(self.additionalRenders) \(self.rawValue) -allowProvisioningUpdates -allowProvisioningDeviceRegistration"
  }
}