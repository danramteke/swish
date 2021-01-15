
extension Altool {

  public struct Upload: ShellAction {
    public let platform: Platform
    public let file: Path
    public let username: String
    private let password: Password

    public init(platform: Platform, file: Path, username: String, password: Password) {
      self.platform = platform
      self.file = file
      self.username = username
      self.password = password
    }

    public var name: String { "Altool.Upload" }
    public func render() -> [String] {
      return ["xcrun", "altool", 
        "--upload-app", 
        "-f", file.absolute().path,
        "--username", username,
      ] + password.renderedList
    }
  }
}
