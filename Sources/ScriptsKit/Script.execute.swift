import SwishKit
import ScriptsDescription

extension Script {
	func execute() throws {
		switch self {
		case .text(let text):
			try sh(text)
		}
	}
}
