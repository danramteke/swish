// xcrun altool --upload-app -t ios \
//   -f ./.build/GrowFlowRetail.ipa \
//   -u $APP_LOADER_USERNAME -p $APP_LOADER_PASSWORD && \

extension Altool {

  public struct Upload: ShellAction {
    private let credentials: Credentials
    public let file: Path
    public let platform: Platform
    public init(platform: Platform, file: Path, credentials: Credentials) {
      self.platform = platform
      self.file = file
      self.credentials = credentials
    }
    public init(platform: Platform, file: Path, username: String, password: String) {
      self.platform = platform
      self.file = file
      self.credentials = Credentials(username: username, password: password)
    }
    public var name: String { return "Altool.Upload" }
    public func render() -> [String] {
      return ["xcrun", "altool", "--upload-app", "-f", file.absolute().path] + credentials.renderedList
    }
  }
}
