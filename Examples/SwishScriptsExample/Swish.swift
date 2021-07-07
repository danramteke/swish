let swish = Swish(
	scripts: [
	"clean": "swift package clean",
	"status": "git status -b porcelain",
	"bootstrap-plain": "swift run --package-path swift-scripts bootstrap",
	"bootstrap": SwiftTarget(path: "swift-scripts", target: "bootstrap"),
	"bootstrap-with-args": SwiftTarget(path: "swift-scripts", target: "bootstrap", arguments: "some args"),
])
