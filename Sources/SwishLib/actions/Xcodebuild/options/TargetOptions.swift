import Rainbow
extension Xcodebuild {
  public struct TargetOptions: Codable {
    public let configuration: String?
    public let scheme: String
    public let project: String?
    public let workspace: String?

    public init(configuration: String? = nil, scheme: String, project: String? = nil, workspace: String? = nil) {
      self.configuration = configuration
      self.project = project
      self.scheme = scheme
      self.workspace = workspace
    }

    var renderedList: [String] {
      var buffer: [String] = ["-scheme", scheme]
      if let configuration = configuration {
        buffer += ["-configuration", configuration]
      }
      if let project = project {
        buffer += ["-project", "\(project).xcodeproj"]
      }
      if let workspace = workspace {
        buffer += ["-workspace", "\(workspace).xcworkspace"]
      }
      return buffer
    }

    var rendered: String {
      return renderedList.joined(separator: " ")
    }
  }
}

extension Xcodebuild.TargetOptions: CustomStringConvertible {
  public var description: String {
    var buffer: [String] = []
    if let configuration = configuration {
      buffer.append("configuration: \(configuration)")
    }

    buffer.append("scheme: \(scheme)")

    if let project = project {
      buffer.append("project: \(project)")
    }
    if let workspace = workspace {
      buffer.append("workspace: \(workspace)")
    }

    return "TargetOptions(".lightBlue + buffer.joined(separator: ",".yellow) + ")".lightBlue
  }
}
