import Foundation

extension ShellRunner {

	public func resolve<T: Target>(_ target: T, force: Bool = false) throws {

		if resolutionLog.contains(target.id) {
			self.logger.alreadyResolved(target.id)
			return
		}

		try self.runDependencies(of: target, force: force)
		try self.runCommand(of: target, force: force)
	}

	private func runDependencies<T: Target>(of target: T, force: Bool) throws {
		self.logger.startResolution(of: target.id, dependsOn: target.dependsOn.map { $0.id })
		for dependentTargetId in target.dependsOn {
			try self.resolve(dependentTargetId, force: force)
		}
	}

	private func runCommand<T: Target>(of target: T, force: Bool) throws {
		let command = target.command
		if command.isRequired || force {
			self.logger.running(target.id)
			try command.execute()
			self.resolutionLog.append(target.id)
		} else {
			self.logger.skipping(target.id)
		}
	}
}
