import Foundation

extension ShellRunner {

	public func resolve<T: TargetID>(_ targetID: T, force: Bool = false) throws {

		if resolutionLog.contains(targetID.name) {
			self.logger.alreadyResolved(targetID.name)
			return
		}

		self.logger.startResolution(of: targetID.name, dependsOn: targetID.dependsOn.map { $0.name })

		for dependentTargetId in targetID.dependsOn {
			try self.resolve(dependentTargetId, force: force)
		}

		let target = targetID.target
		if target.isNeeded || force {
			try target.execute()
			self.resolutionLog.append(targetID.name)
		} else {
			self.logger.skipping(targetID.name)
		}
	}
}
