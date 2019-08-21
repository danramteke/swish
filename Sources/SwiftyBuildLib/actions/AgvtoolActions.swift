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
  public let name = "avgtool next version"
  public let all: Bool
  public init(all: Bool = true) {
    self.all = all
  }

  public func render() -> [String] {
    var buffer = ["xcrun", "agvtool", "new-version"]
    if all {
      buffer.append("-all")
    }
    return buffer
  }
}

public struct NewVersion: ShellAction {
  public let name = "avgtool new version"
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

public struct NewMarketingVersion {
  public let name = "avgtool new marketing version"
  public let string: String 
  public init(_ string: String) {
    self.string = string
  }

  public func render() -> [String] {
    return ["xcrun", "agvtool", "new-marketing-version", string]
  }
}
