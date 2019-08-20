public struct TargetOptions {
  public let configuration: String?
  public let scheme: String?
  public let project: String?
  public let workspace: String?

  public init(configuration: String? = nil, project: String? = nil, scheme: String? = nil, workspace: String? = nil) {
    self.configuration = configuration
    self.project = project
    self.scheme = scheme
    self.workspace = workspace
  }

  var rendered: String {
    var buffer: [String] = []
    if let configuration = configuration {
      buffer.append("-configuration \(configuration)")
    }
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
