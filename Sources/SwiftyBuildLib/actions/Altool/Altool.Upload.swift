// xcrun altool --upload-app -t ios \
//   -f ./.build/GrowFlowRetail.ipa \
//   -u $APP_LOADER_USERNAME -p $APP_LOADER_PASSWORD && \

extension Altool {

  public struct Upload: ShellAction {
    let credentials: Credentials
    let file: Path
    let platform: Platform

    public var name: String { return "Altool.Upload" }
    public func render() -> [String] {
      return ["xcrun", "altool", "--upload-app", "-f", file.absolute().path] + credentials.renderedList
    }
  }
}
