// swift-tools-version:5.3

import PackageDescription

let package = Package(
	name: "Swish",
	platforms: [
		.macOS(.v11)
	],
	products: [
		.executable(name: "swish", targets: ["swish"]),
		.library(name: "SwishDescription", targets: ["SwishDescription"]),

		.library(name: "SwishKit", targets: ["SwishKit"]),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-log.git", from: "1.4.2"),
		.package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.4.0"),
		.package(url: "https://github.com/jpsim/Yams.git", from: "4.0.0"),
		.package(url: "https://github.com/danramteke/MPath.git", from: "0.9.12"),
    
	],
	targets: [

		.target(
			name: "swish", // main executable
			dependencies: [
				"SwishDescription", 
				"SwishCommand",
			]
		),

		.target(
			name: "SwishKit", // library to use in your own scripting projects
			dependencies: [
				"MPath",
				.product(name: "Logging", package: "swift-log"),
			]),

		.target(
			name: "SwishDescription", // Description of Swish.swift/Swish.yaml/Swish.json
			dependencies: []
		),

		.target(
			name: "SwishCommand", // code for `swish` executable
			dependencies: [
				"SwishDescription",
				"MPath",
				"Yams",

				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			]
		),

// Tests //

		.testTarget(name: "SwishDescriptionTests", dependencies: [
			"SwishDescription", 
			"Yams",
		]),

		.testTarget(
			name: "SwishKitTests",
			dependencies: [
				"SwishKit",
				.product(name: "Logging", package: "swift-log"),
			]
		),		
	]
)
