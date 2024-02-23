// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "WWDC2024",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "WWDC2024",
            targets: ["AppModule"],
            bundleIdentifier: "Narciso.WWDC2024",
            teamIdentifier: "6YA78MTDS8",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .star),
            accentColor: .asset("AccentColor"),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .landscapeRight
            ],
            appCategory: .arcadeGames
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .process("Resources")
            ]
        )
    ]
)