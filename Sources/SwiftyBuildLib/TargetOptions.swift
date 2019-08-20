public struct TargetOptions {
  public let scheme: String?
  public let project: String?
  public let workspace: String?

  public init(project: String? = nil, scheme: String? = nil, workspace: String? = nil) {
    self.project = project
    self.scheme = scheme
    self.workspace = workspace
  }

  var rendered: String {
    var buffer: [String] = []
    if let scheme = scheme {
      buffer.append("-scheme \(scheme)")
    }
    if let project = project {
      buffer.append("-project \(project).xcodeproj")
    }
    if let workspace = workspace {
      buffer.append("-workspace \(workspace).xcworkspace")
    }
    return buffer.joined(separator: " ")
  }
}
