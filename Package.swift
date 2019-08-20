// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyBuild",
    products: [
        .executable(name: "SwiftyBuild", targets: ["SwiftyBuild"]),
        .library(name: "SwiftyBuildLib", targets: ["SwiftyBuildLib"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftyBuild",
            dependencies: ["SwiftyBuildLib"]),
        .target(
            name: "SwiftyBuildLib",
            dependencies: []),
        .testTarget(
            name: "SwiftyBuildTests",
            dependencies: ["SwiftyBuild"]),
    ]
)
