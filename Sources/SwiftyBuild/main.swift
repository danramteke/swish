import SwiftyBuildLib

let projectOptions = ProjectOptions(scheme: "MyScheme", workspace: "MyWorkspace")

print(BuildAction.build.render(options: projectOptions))