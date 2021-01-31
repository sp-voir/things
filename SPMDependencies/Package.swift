// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SPMDependencies",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "ComposableUIKitArchitecture",
            targets: ["ComposableUIKitArchitecture"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "0.9.0"),
        .package(url: "https://github.com/makeupstudio/swift-declarative-configuration.git", .branch("main")),
    ],
    targets: [
        .target(
            name: "ComposableUIKitArchitecture",
            dependencies: [
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
                .product(
                    name: "FunctionalClosures",
                    package: "swift-declarative-configuration"
                )
            ]
        ),
    ]
)
