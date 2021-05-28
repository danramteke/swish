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
    ],
    targets: [
        .executableTarget(
            name: "AppIconRender",
            dependencies: [
                .product(name: "SwishKit", package: "Swish"),
                ]),
    ]
)
