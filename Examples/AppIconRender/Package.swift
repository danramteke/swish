// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "AppIconRender",
    platforms: [.macOS(.v11)],
    products: [
        .executable(name: "AppIconRender", targets: ["AppIconRender"]),
    ],
    dependencies: [
        .package(name: "Swish", path: "../../"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.0"),
    ],
    targets: [
        .executableTarget(
            name: "AppIconRender",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "SwishKit", package: "Swish"),
                ]),
    ]
)
