import SwishKit
struct AllAction: Action {
    let id: ActionID = .all

    var dependsOn: [ActionID] {
        [.icons, .alpha]
    }

    /// `execute` is empty, since all this action does is declare some dependencies
    func execute() throws { }
}