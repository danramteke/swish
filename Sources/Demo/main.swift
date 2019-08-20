import SwiftyBuildLib

let options = TargetOptions(scheme: "MyScheme", workspace: "MyWorkspace")

BuildAction.build(options).run()