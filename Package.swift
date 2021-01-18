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

        .package(url: "https://github.com/apple/swift-nio.git", from: "2.25.1"),
    ],
    targets: [
        .target(
            name: "swish",
            dependencies: ["SwishLib"]),
        .target(
            name: "SwishLib",
            dependencies: [
              "Rainbow", "Version", .product(name: "NIO", package: "swift-nio")
            ]),
        .testTarget(
            name: "SwishTests",
            dependencies: ["SwishLib"]),
        .target(
            name: "BuildiOSAppDemo",
            dependencies: ["SwishLib"]),
    ]
)

#if !canImport(Combine)
package.dependencies.append(.package(url: "https://github.com/OpenCombine/OpenCombine.git", from: "0.11.0"))
package.targets.first(where: { $0.name == "SwishLib"})?.dependencies.append("OpenCombine")
#else

#endif
