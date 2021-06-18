import SwishDescription
let swish = Swish(
	scripts: [
	"clean": "swift package clean",
	"status": "git status -b porcelain",
	"bootstrap-plain": "swift run --package-path swift-scripts bootstrap",
	"bootstrap": SwishKit(target: "bootstrap", path: "swift-scripts"),
])
