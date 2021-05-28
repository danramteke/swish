// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swish",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .executable(name: "swish", targets: ["swish"]),
        .library(name: "SwishKit", targets: ["SwishKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Rainbow.git", from: "3.0.0"),
        .package(url: "https://github.com/danramteke/MPath.git", from: "0.9.7"),
    ],
    targets: [
        .executableTarget(
            name: "swish",
            dependencies: [
                "SwishKit",
                "MPath",
            ]),
        .target(
            name: "SwishKit",
            dependencies: [
                "Rainbow",
                "MPath",
            ]),
        .testTarget(
            name: "SwishKitTests",
            dependencies: ["SwishKit"]),
    ]
)
