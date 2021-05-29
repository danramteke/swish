import SwishKit
protocol Action: Identifiable {
	var id: ActionID { get }
	var dependsOn: [ActionID] { get }

	func execute() throws
}

extension Action {
	var dependsOn: [ActionID] { [] }
}
