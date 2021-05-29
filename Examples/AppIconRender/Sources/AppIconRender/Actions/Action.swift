import SwishKit
import MPath

protocol Action {
	var id: ActionID { get }
	var dependsOn: [ActionID] { get }

	var isNeeded: Bool { get }

	func execute() throws

	func resolve(force: Bool) throws
}

extension Action {
	var dependsOn: [ActionID] { [] }
	var isNeeded: Bool { true }
	func resolve(force: Bool) throws {
		try self.dependsOn.forEach {
			try $0.action.resolve(force: force)
		}

    if self.isNeeded || force {
			try self.execute()
    } else {
    	//print("Skipping \(self.id), not needed".red)
    }
	}
}

protocol FileAction: Action {
	var inputs: [Path] { get }
	var outputs: [Path] { get }
}

extension FileAction {
	var isNeeded: Bool {
		do {
			guard outputs.allExist else {
				return true
			}
			guard let maxInputDate = try inputs.map({ try $0.modificationDate() }).max() else {
				return true
			}
			guard let minOutputDate = try outputs.map({ try $0.modificationDate() }).min() else {
				return true
			}

			guard maxInputDate < minOutputDate else {
				return true
			}

			return false
		} catch {
			print("error getting isNeeded for \(id.rawValue)", error)
			return true
		}
	}
}
