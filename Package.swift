// swift-tools-version:5.3

import PackageDescription

let package = Package(
	name: "Swish",
	platforms: [
		.macOS(.v11)
	],
	products: [
		.library(name: "SwishKit", targets: ["SwishKit"]),
		.library(name: "SwishDescription", targets: ["SwishDescription"]),
		.library(name: "SwishCommand", targets: ["SwishCommand"]),
		.executable(name: "swish", targets: ["swish"]),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-log.git", from: "1.4.2"),
		.package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.4.0"),
		.package(url: "https://github.com/jpsim/Yams", from: "4.0.0"),
		.package(url: "https://github.com/danramteke/MPath.git", from: "0.9.9"),
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

		.target(
			name: "SwishDescription",
			dependencies: []
		),

		.target(
			name: "SwishCommand",
			dependencies: [
				"SwishDescription",
				"MPath",
				"Yams",
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			]
		),

		.testTarget(name: "SwishDescriptionTests", dependencies: ["SwishDescription", "Yams"]),

		.target(
			name: "swish",
			dependencies: ["SwishDescription", "SwishCommand"]
		)
	]
)
