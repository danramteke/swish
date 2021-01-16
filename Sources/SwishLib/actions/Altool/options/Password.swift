import Foundation

extension Altool {
  public enum Password: RawRepresentable, Codable {
    case literal(String)
    case env(String)
    case keychain(String)

    public init?(rawValue: String) {
      if rawValue.starts(with: Password.keychainPrefix), let keychain = rawValue.removing(prefix: Password.keychainPrefix) {
        self = .keychain(keychain)
      } else if rawValue.starts(with: Password.envPrefix), let env = rawValue.removing(prefix: Password.envPrefix) {
        self = .env(env)
      } else {
        self = .literal(rawValue)
      }
    }

    public static let envPrefix: String = "@env:"
    public static let keychainPrefix: String = "@keychain:"

    public var rawValue: String {
      switch self {
      case .env(let name):
        return Password.envPrefix + name
      case .literal(let password):
        return password
      case .keychain(let name):
        return Password.keychainPrefix + name
      }
    }
    

    public var renderedList: [String] {
      return ["--password", self.rawValue]
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