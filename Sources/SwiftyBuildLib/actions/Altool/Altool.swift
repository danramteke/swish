public enum Altool {
  public enum Platform: String, Codable {
    case osx, ios, appletvos

    public var renderedList: [String] {
      return ["--type", self.rawValue]
    }
  }

  public enum Password {
    case .literal(String)
    case .env(String)
    case .keychain(String)

    public init(_ string: String) {
      self = .literal(String)
    }

    public var renderedList: String {
      return ["--password"] + {
        switch self {
        case .env(let name):
          return "@env:\(name)"
        case .literal(let password):
          return password
        case .keychain(let name):
          return "@keychain:\(name)"
        }
      }()
    }
/*
        Password. Required if username specified.
    If this argument is not supplied on the command line, it will be read from stdin.
    Alternatively to entering <password> in plaintext, it may also be specified using a '@keychain:'
    or '@env:' prefix followed by a keychain password item name or environment variable name.
    Example: '-p @keychain:<name>' uses the password stored in the keychain password item named <name>
                                    and whose Account value matches the user name specified
    Example: '-p @env:<variable>'  uses the value in the environment variable named <variable>
                                    */
  }
}
