// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SwishScript",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .executable(name: "SwishScript", targets: [
            "SwishScript"
        ])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "SwishScript",
                dependencies: [],
                path: "src"
        ),
    ]
)
