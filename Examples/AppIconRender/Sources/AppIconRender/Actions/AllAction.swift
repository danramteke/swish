import SwishKit
struct AllAction: Action {

    var dependsOn: [AppIconRenderActionID] {
        [.icons, .alpha]
    }

    /// `execute` is empty, since all this action does is declare some dependencies
    func execute() throws { }
}