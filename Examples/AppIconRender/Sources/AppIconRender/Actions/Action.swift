import SwishKit
import MPath

protocol Action {
	var id: ActionID { get }
	var dependsOn: [ActionID] { get }

	var isNeeded: Bool { get }

	func execute() throws
}

extension Action {
	var dependsOn: [ActionID] { [] }
	var isNeeded: Bool { true }
}

protocol FileAction: Action {
	var inputs: [Path] { get }
	var outputs: [Path] { get }
}

struct Resolver {
    func go(action: Action) throws {
        try action.dependsOn.forEach {
            try go(action: $0.action)
        }

        if action.isNeeded {
            try action.execute()
        } else {
            print("Skipping \(action.id), not needed".red)
        }
    }
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
