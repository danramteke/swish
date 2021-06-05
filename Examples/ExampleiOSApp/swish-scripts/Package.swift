// swift-tools-version:5.4

import PackageDescription

let package = Package(
  name: "ExampleAppScripts",
  platforms: [.macOS(.v11)],
  products: [
      .executable(name: "bootstrap", targets: ["bootstrap"]),
      .executable(name: "appstore", targets: ["appstore"]),
  ], 
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.0"),
    .package(name: "Swish", path: "../../.."),

  ],
  targets: [
    .executableTarget(name: "bootstrap", 
        dependencies: [
            .product(name: "SwishKit", package: "Swish"),
            .product(name: "ArgumentParser", package: "swift-argument-parser")]),
    .executableTarget(name: "appstore", 
        dependencies: [
            .product(name: "SwishKit", package: "Swish"),
            .product(name: "ArgumentParser", package: "swift-argument-parser")]),
  ]
)