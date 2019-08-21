import Foundation
/*
    agvtool help
    agvtool what-version | vers [-terse]
    agvtool [-noscm | -usecvs | -usesvn] next-version | bump [-all]
    agvtool [-noscm | -usecvs | -usesvn] new-version [-all] <versNum>
    agvtool [-noscm | -usecvs | -usesvn] tag [-force | -F] [-noupdatecheck | -Q] [-baseurlfortag]
    agvtool what-marketing-version | mvers [-terse | -terse1]
    agvtool [-noscm | -usecvs | -usesvn] new-marketing-version <versString>
    */
public struct NextVersion: ShellAction {
  public let name = "AvgtoolNextVersion"
  public let all: Bool
  public init(all: Bool = true) {
    self.all = all
  }

  public func render() -> [String] {
    var buffer = ["xcrun", "agvtool", "next-version"]
    if all {
      buffer.append("-all")
    }
    return buffer
  }
}

public extension Context {
  func nextVersion(all: Bool = true) throws {
    let action = NextVersion(all: all)
    try self.run(action: action)
  }
}

public struct NewVersion: ShellAction {
  public let name = "AvgtoolNewVersion"
  public let number: Int
  public let all: Bool
  public init(number: Int, all: Bool = true) {
    self.number = number
    self.all = all
  }

  public func render() -> [String] {
    var buffer = ["xcrun", "agvtool", "new-version", String(number)]
    if all {
      buffer.append("-all")
    }
    return buffer
  }
}

public extension Context {
  func newVersion(number: Int, all: Bool = true) throws {
    let action = NewVersion(number: number, all: all)
    try self.run(action: action)
  }
}

public struct NewMarketingVersion: ShellAction {
  public let name = "AvgtoolNewMarketingVersion"
  public let string: String 
  public init(_ string: String) {
    self.string = string
  }

  public func render() -> [String] {
    return ["xcrun", "agvtool", "new-marketing-version", string]
  }
}

public extension Context {
  func newMarketingVersion(_ string: String) throws {
    let action = NewMarketingVersion(string)
    try self.run(action: action)
  }
}