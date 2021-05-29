import Foundation

struct MvgTemplate {
    let foregroundColor = "white"
    let backgroundColor = "blue"

    let edge: Decimal
    let points: [Point]
    init(edge: Decimal) {
        self.edge = edge
        let factor: Decimal = edge/Decimal(512)
        self.points = [   
            Point(70,70),
            Point(134,70),
            Point(134,134),
            Point(70,134),
        ].map { $0.scaled(by: factor) }
    }

    func render() -> String {
        self.renderString(
            edge: "\(edge)", 
            path: self.points.asImageMagickPath, 
            foregroundColor: foregroundColor, 
            backgroundColor: backgroundColor)
    }

    private func renderString(edge: String, path: String, foregroundColor: String, backgroundColor: String) -> String {
        """
        push graphic-context
            viewbox 0 0 \(edge) \(edge)
            push graphic-context
                fill \(backgroundColor)
                rectangle 0,0 \(edge),\(edge)
            pop graphic-context

            push graphic-context
                fill \(foregroundColor)
                path \(path) 
            pop graphic-context
        pop graphic-context
        """
    }
}

extension Point {
  var asImageMagickPoint: String {
    return "\(self.x),\(self.y)"
  }
}

extension Array where Element == Point {
  var asImageMagickPath: String {
    guard self.count >= 2 else {
      fatalError("need at least 2 points")
    }

    let firstPoint = self.first!.asImageMagickPoint
    let otherPoints = self.dropFirst().map { $0.asImageMagickPoint }.joined(separator: " ")

    return "M\(firstPoint) L\(otherPoints)" 
  }
}
