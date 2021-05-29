import SwishKit
struct AllAction: Action {
    let id: ActionID = .all

    var dependsOn: [ActionID] {
        [.icons, .alpha]
    }

    func execute() throws { }
}