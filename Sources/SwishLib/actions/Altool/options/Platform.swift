extension Altool {
  public enum Platform: String, Codable {
    case osx, ios, appletvos

    public var renderedList: [String] {
      return ["--type", self.rawValue]
    }
  }
}
