// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "DotSettingsKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "DotSettingsKit",
            targets: ["DotSettingsKit"]
        )
    ],
    targets: [
        .target(name: "DotSettingsKit"),
        .testTarget(
            name: "DotSettingsKitTests",
            dependencies: ["DotSettingsKit"]
        )
    ]
)
