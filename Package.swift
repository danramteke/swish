// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyBuild",
    products: [
        .executable(name: "SwiftyBuild", targets: ["SwiftyBuild"]),
        .executable(name: "Demo", targets: ["Demo"]),
        .library(name: "SwiftyBuildLib", targets: ["SwiftyBuildLib"])
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0")
    ],
    targets: [
        .target(
            name: "SwiftyBuild",
            dependencies: ["SwiftyBuildLib"]),
        .target(
            name: "SwiftyBuildLib",
            dependencies: ["Rainbow"]),
        .testTarget(
            name: "SwiftyBuildTests",
            dependencies: ["SwiftyBuild"]),
        .target(
            name: "Demo",
            dependencies: ["SwiftyBuildLib"]),
    ]
)
