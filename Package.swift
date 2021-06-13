// swift-tools-version:5.4

import PackageDescription

let package = Package(
	name: "Swish",
	platforms: [
		.macOS(.v11)
	],
	products: [
		.library(name: "SwishKit", targets: ["SwishKit"])
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-log.git", from: "1.4.2"),
		.package(url: "https://github.com/danramteke/MPath.git", from: "0.9.8"),
	],
	targets: [
		.target(
			name: "SwishKit",
			dependencies: [
				"MPath",
				.product(name: "Logging", package: "swift-log"),
			]),
		.testTarget(
			name: "SwishKitTests",
			dependencies: [
				"SwishKit",
				.product(name: "Logging", package: "swift-log"),
			]),
	]
)
