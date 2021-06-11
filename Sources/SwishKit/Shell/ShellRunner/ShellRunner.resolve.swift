import Foundation

extension ShellRunner {

	public func resolve<T: TargetID>(_ targetID: T, force: Bool = false) throws {

		if resolutionLog.contains(targetID.id) {
			self.logger.alreadyResolved(targetID.id)
			return
		}

		self.logger.startResolution(of: targetID.id, dependsOn: targetID.dependsOn.map { $0.id })

		for dependentTargetId in targetID.dependsOn {
			try self.resolve(dependentTargetId, force: force)
		}

		let target = targetID.target
		if target.isNeeded || force {
			try target.execute()
			self.resolutionLog.append(targetID.id)
		} else {
			self.logger.skipping(targetID.id)
		}
	}
}
