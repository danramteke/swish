// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "DockerDev",
    platforms: [.macOS(.v11)],
    products: [
        .executable(name: "DockerDev", targets: ["DockerDev"]),
    ],
    dependencies: [
        .package(name: "Swish", path: "../../"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.0"),
    ],
    targets: [
        .executableTarget(
            name: "DockerDev",
            dependencies: [
                .product(name: "SwishKit", package: "Swish"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                ]),
    ]
)
