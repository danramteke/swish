public struct SwiftCommand: ShellCommand {
    public let shellRunner: ShellRunner
    public let label: String? 
    public let path: String
    public let target: String
    public let arguments: String
    public let environment: [String: String]?
    public let options: ShellOptions

    public init(shellRunner: ShellRunner = SwishContext.default.shellRunner,
                label: String? = nil,
                path: String,
                target: String,
                arguments: String,
                environment: [String: String]? = nil,
                options: ShellOptions = .default) {
        self.shellRunner = shellRunner
        self.label = label
        self.path = path
        self.target = target
        self.arguments = arguments
        self.environment = environment
        self.options = options
    }

    public var text: String {
        "swift run --package-path \(path) \(target) \(arguments)"
    }
}
