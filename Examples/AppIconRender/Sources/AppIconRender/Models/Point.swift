import Foundation

struct Point {
  let x: Decimal
  let y: Decimal

  init(_ x: Decimal, _ y: Decimal) {
    self.x = x; self.y = y
  }

  func scaled(by factor: Decimal) -> Point {
    return Point(self.x * factor, self.y * factor)
  }
}
