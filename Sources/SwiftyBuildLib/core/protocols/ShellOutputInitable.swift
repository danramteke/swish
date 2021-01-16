//
//  File.swift
//  
//
//  Created by Daniel R on 1/15/21.
//

import Foundation



public protocol ShellQueryOutputInitable {
  init(shellQueryOutput output: String) throws
}



extension RawRepresentable where RawValue == String {
  public init(shellQueryOutput: String) throws {
    let trimmedOutput = shellQueryOutput.trimmingCharacters(in: .whitespacesAndNewlines)
    guard let value = Self.init(rawValue: trimmedOutput) else {
      throw RunError.parseError
    }

    self = value
  }
}

extension String: ShellQueryOutputInitable {
  public init(shellQueryOutput: String) throws {
    self = shellQueryOutput.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}

extension Int: ShellQueryOutputInitable {
  public init(shellQueryOutput: String) throws {
    let trimmedOutput = shellQueryOutput.trimmingCharacters(in: .whitespacesAndNewlines)
    guard let value = Int(trimmedOutput) else {
      throw RunError.parseError
    }

    self = value
  }
}

extension Path: ShellQueryOutputInitable {
  public init(shellQueryOutput: String) throws {
    self.init(shellQueryOutput.trimmingCharacters(in: .whitespacesAndNewlines))
  }
}
