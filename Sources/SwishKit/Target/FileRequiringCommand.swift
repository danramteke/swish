import Foundation
import MPath

public protocol FileRequiringCommand: RequirableCommand {
	var inputs: [Path] { get }
	var outputs: [Path] { get }
}

public extension FileRequiringCommand {
	var isRequired: Bool {
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
			fatalError("error getting `isNeeded` for \(self)", error)
			return true
		}
	}
}
