// swift-tools-version:5.3

import PackageDescription

let package = Package(
	name: "Scripts",
	platforms: [
		.macOS(.v11)
	],
  products: [
    .executable(name: "bootstrap", targets: ["bootstrap"])
  ],
  targets: [
    .target(name: "bootstrap", dependencies: [])
  ]
)
