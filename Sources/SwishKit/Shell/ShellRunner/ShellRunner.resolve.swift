import Foundation

extension ShellRunner {

	public func resolve<T: TargetID>(_ targetID: T, force: Bool) throws {

		self.logger.startResolution(of: targetID.name, dependsOn: targetID.dependsOn.map { $0.name })

		for dependentTargetId in targetID.dependsOn {
			try self.resolve(dependentTargetId, force: force)
		}

		let target = targetID.target
		if target.isNeeded || force {
			try target.execute()
		} else {
			self.logger.skipping(targetID.name)
		}
	}
}
