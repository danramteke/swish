// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swish",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "swish", targets: ["swish"]),
        .library(name: "SwishLib", type: .dynamic, targets: ["SwishLib"])
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Rainbow.git", from: "3.0.0"),
        .package(url: "https://github.com/mxcl/Version.git", from: "1.0.0"),
//        .package(url: "https://github.com/OpenCombine/OpenCombine.git", from: "0.11.0"),
    ],
    targets: [
        .target(
            name: "swish",
            dependencies: ["SwishLib"]),
        .target(
            name: "SwishLib",
            dependencies: ["Rainbow", "Version",
//                           "OpenCombine",
            ]),
        .testTarget(
            name: "SwishTests",
            dependencies: ["SwishLib"]),
        .target(
            name: "BuildiOSAppDemo",
            dependencies: ["SwishLib"]),
    ]
)
