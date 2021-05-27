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
        .package(url: "https://github.com/mxcl/Version.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.0"),
        .package(url: "https://github.com/danramteke/MPath.git", from: "0.9.7"),
    ],
    targets: [
        .executableTarget(
            name: "swish",
            dependencies: [
                "SwishKit",
                "MPath",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .target(
            name: "SwishKit",
            dependencies: [
              "Rainbow", "Version", "MPath",
            ]),
        .testTarget(
            name: "SwishKitTests",
            dependencies: ["SwishKit"]),
    ]
)

#if !canImport(Combine)
package.dependencies.append(.package(url: "https://github.com/OpenCombine/OpenCombine.git", from: "0.11.0"))
package.targets.first(where: { $0.name == "SwishKit"})?.dependencies.append("OpenCombine")
#else

#endif
