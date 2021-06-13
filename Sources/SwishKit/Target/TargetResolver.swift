import Foundation
import Logging

public class TargetResolver {
	public private(set) var resolutionLog: [String] = []

	private let logger: TargetResolverLogger
	public init(logLevel: Logging.Logger.Level) {
		self.logger = TargetResolverLogger(logLevel: logLevel)
	}

	public func resolve<T: Target>(_ target: T) throws {

		if resolutionLog.contains(target.id) {
			self.logger.alreadyResolved(target.id)
			return
		}

		try self.runDependencies(of: target)
		try self.runCommand(of: target)
	}

	private func runDependencies<T: Target>(of target: T) throws {
		self.logger.startResolution(of: target.id, dependsOn: target.dependsOn.map { $0.id })
		for dependentTargetId in target.dependsOn {
			try self.resolve(dependentTargetId)
		}
	}

	private func runCommand<T: Target>(of target: T) throws {
		if let command = target.command {
			self.logger.running(target.id)
			try command.execute()
		} else {
			self.logger.skipping(target.id)
		}

		self.resolutionLog.append(target.id)
	}
}
