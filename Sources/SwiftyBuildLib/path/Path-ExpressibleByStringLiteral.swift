extension Path: ExpressibleByStringLiteral {
  public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
  public typealias UnicodeScalarLiteralType = StringLiteralType

  public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
    self.init(String(value))
  }

  public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
    self.init(String(value))
  }

  public init(stringLiteral value: StringLiteralType) {
    self.init(value)
  }
}
