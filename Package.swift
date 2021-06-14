// swift-tools-version:5.4

import PackageDescription

let package = Package(
	name: "Swish",
	platforms: [
		.macOS(.v11)
	],
	products: [
		.library(name: "SwishKit", targets: ["SwishKit"]),
		.library(name: "ScriptsDescription", targets: ["ScriptsDescription"]),
		.library(name: "ScriptsKit", targets: ["ScriptsKit"]),
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
			name: "ScriptsDescription",
			dependencies: []
		),

		.target(
			name: "ScriptsKit",
			dependencies: [
				"ScriptsDescription",
                "MPath",
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				"Yams",
			]
		),

		.testTarget(name: "ScriptsDescriptionTests", dependencies: ["ScriptsDescription", "Yams"]),

		.executableTarget(
			name: "swish",
			dependencies: ["ScriptsDescription", "ScriptsKit"]
		)
	]
)
