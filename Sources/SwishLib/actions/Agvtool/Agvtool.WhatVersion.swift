#if canImport(Combine)
import Combine
#else
import OpenCombine
#endif

extension Agvtool {
  public class WhatVersion: ShellQuery {
    public let id = ID()
    public typealias ResultSuccessType = Int

    public let name = "Avgtool.WhatVersion"
    public init() { }

    public func render() -> [String] {
      return ["xcrun", "agvtool", "what-version", "-terse"]
    }

    public var publisher: CurrentValueSubject<ResultSuccessType, Never> = .init(0)
  }
}
