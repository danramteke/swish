public enum Altool {
  public enum Platform: String, Codable {
    case osx, ios, appletvos

    public var renderedList: [String] {
      return ["--type", self.rawValue]
    }
  }

  public struct Credentials: Codable {
    /*
    Password. Required if username specified.
    If this argument is not supplied on the command line, it will be read from stdin.
    Alternatively to entering <password> in plaintext, it may also be specified using a '@keychain:'
    or '@env:' prefix followed by a keychain password item name or environment variable name.
    Example: '-p @keychain:<name>' uses the password stored in the keychain password item named <name>
                                    and whose Account value matches the user name specified
    Example: '-p @env:<variable>'  uses the value in the environment variable named <variable>
                                    */
    public let username: String
    public let password: String

    public init(username: String, passwordKeychainName: String) {
      self.username = username
      self.password = "@keychain:\(passwordKeychainName)"
    }

    public init(username: String, passwordEnvVariableName: String) {
      self.username = username
      self.password = "@env:\(passwordEnvVariableName)"
    }

    public init(username: String, password: String) {
      self.username = username
      self.password = password
    }

    public var renderedList: [String] {
      return ["--username", self.username, "--password", self.password]
    }
  }
}