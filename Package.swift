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
        ),
        .executable(
            name: "DotSettingsKitExample",
            targets: ["DotSettingsKitExample"]
        )
    ],
    targets: [
        .target(name: "DotSettingsKit"),
        .executableTarget(
            name: "DotSettingsKitExample",
            dependencies: ["DotSettingsKit"],
            path: "Example/DotSettingsKitExample"
        ),
        .testTarget(
            name: "DotSettingsKitTests",
            dependencies: ["DotSettingsKit"]
        )
    ]
)
