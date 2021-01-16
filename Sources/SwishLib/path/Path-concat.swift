/*
 * The `Path` section of code was heavily borrowed and inspired by [PathKit](https://github.com/kylef/PathKit/blob/master/Sources/PathKit.swift). 
 * The license for the borrowed code is available [here](https://github.com/kylef/PathKit/blob/master/LICENSE).
 */

import Foundation
extension Path {
  

  public init<S : Collection>(components: S) where S.Iterator.Element == String {
    if components.isEmpty {
      path = "."
    } else if components.first == Path.separator && components.count > 1 {
      let p = components.joined(separator: Path.separator)
      path = String(p[p.index(after: p.startIndex)...])
    } else {
      path = components.joined(separator: Path.separator)
    }
  }
}

public func +(lhs: Path, rhs: Path) -> Path {
  return lhs.path + rhs.path
}

/// Appends a String fragment to another Path to produce a new Path
public func +(lhs: Path, rhs: String) -> Path {
  return lhs.path + rhs
}

/// Appends a String fragment to another String to produce a new Path
private func +(lhs: String, rhs: String) -> Path {
  if rhs.hasPrefix(Path.separator) {
    // Absolute paths replace relative paths
    return Path(rhs)
  } else {
    var lSlice = NSString(string: lhs).pathComponents.fullSlice
    var rSlice = NSString(string: rhs).pathComponents.fullSlice

    // Get rid of trailing "/" at the left side
    if lSlice.count > 1 && lSlice.last == Path.separator {
      lSlice.removeLast()
    }

    // Advance after the first relevant "."
    lSlice = lSlice.filter { $0 != "." }.fullSlice
    rSlice = rSlice.filter { $0 != "." }.fullSlice

    // Eats up trailing components of the left and leading ".." of the right side
    while lSlice.last != ".." && !lSlice.isEmpty && rSlice.first == ".." {
      if lSlice.count > 1 || lSlice.first != Path.separator {
        // A leading "/" is never popped
        lSlice.removeLast()
      }
      if !rSlice.isEmpty {
        rSlice.removeFirst()
      }

      switch (lSlice.isEmpty, rSlice.isEmpty) {
      case (true, _):
        break
      case (_, true):
        break
      default:
        continue
      }
    }

    return Path(components: lSlice + rSlice)
  }
}

private extension Array {
  var fullSlice: ArraySlice<Element> {
    return self[self.indices.suffix(from: 0)]
  }
}