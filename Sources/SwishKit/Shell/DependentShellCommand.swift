public struct DependentShellCommand: DependantCommand {
	public let text: String
	public let dependsOn: [Command]

	public init(_ text: String, dependsOn: [Command]) {
		self.text = text
		self.dependsOn = dependsOn
	}

	public func execute() -> Result<Void, Error> {
		print("print running:".blue, text)
		return .success(())
	}
}
