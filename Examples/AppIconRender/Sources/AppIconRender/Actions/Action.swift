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

extension FileAction {
	var isNeeded: Bool {
		do {
			guard let maxInputDate = try inputs.map({ try $0.modificationDate() }).max() else {
				return true
			}
			guard let minOutputDate = try outputs.map({ try $0.modificationDate() }).min() else {
				return true
			}

			return maxInputDate < minOutputDate
		} catch {
			print("error getting isNeeded for \(id.rawValue)", error)
			return true
		}
	}
}
