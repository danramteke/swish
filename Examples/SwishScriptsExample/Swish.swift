import SwishDescription
let swish = Swish(
	scripts: [
	"clean": "swift package clean",
	"status": "git status -b porcelain",
	"bootstrap": "swift run --package-path swift-scripts bootstrap"
])
