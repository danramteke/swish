// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "DockerDev",
    products: [
        .executable(name: "DockerDev", targets: ["DockerDev"]),
    ],
    dependencies: [
        .package(name: "Swish", path: "../../"),
    ],
    targets: [
        .executableTarget(
            name: "DockerDev",
            dependencies: [
                .product(name: "SwishKit", package: "Swish"),
                ]),
    ]
)
