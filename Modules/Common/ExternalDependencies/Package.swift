// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExternalDependencies",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ComposableArchitectureApp",
            targets: ["ComposableArchitectureApp", "LoggerApp"]
        ),
        .library(
            name: "LoggerApp",
            targets: ["LoggerApp"]
        ),
        .library(
            name: "FirebaseApp",
            targets: ["FirebaseApp", "LoggerApp"]
        ),
        .library(
            name: "PurchasesApp",
            targets: ["PurchasesApp", "LoggerApp"]
        ),
        .library(
            name: "CombineExtApp",
            targets: ["CombineExtApp"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.11.0"),
        .package(url: "https://github.com/makeupstudio/swift-declarative-configuration", .branch("main")),
        //.package(url: "https://github.com/firebase/firebase-ios-sdk", from: "7.4.0"),
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "7.4.0")),
        .package(url: "https://github.com/apple/swift-log", from: "1.4.0"),
//        .package(name: "CombineExtApp", url: "https://github.com/CombineCommunity/CombineExt.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/CombineCommunity/CombineExt.git", from: "1.2.0"),
        .package(name: "Purchases", url: "https://github.com/RevenueCat/purchases-ios.git", .upToNextMajor(from: "3.10.2")),
        //.package(url: "https://github.com/RevenueCat/purchases-ios.git", from: "3.10.2"),
        //.package(url: "https://github.com/uber/needle.git", from: "0.17.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ComposableArchitectureApp",
            dependencies: [
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
                .product(
                    name: "FunctionalClosures",
                    package: "swift-declarative-configuration"
                ),
            ]
        ),
        .target(
            name: "LoggerApp",
            dependencies: [
                .product(
                    name: "Logging",
                    package: "swift-log"
                ),
            ]
        ),
        .target(
            name: "FirebaseApp",
            dependencies: [
                // The product name you need. In this example, FirebaseAuth.
                .product(name: "FirebaseRemoteConfig", package: "Firebase"),
                .product(name: "FirebaseAuth", package: "Firebase"),
            ],
            resources: [
                .process("GoogleService-Info.plist")
            ]
        ),
        .target(
            name: "PurchasesApp",
            dependencies: [
                .product(
                    name:"Purchases",
                    package: "Purchases"
                )
            ]
        ),
        .target(
            name: "CombineExtApp",
            dependencies: [
                .product(
                    name:"CombineExt",
                    package: "CombineExt"
                )
            ]
        ),
        .testTarget(
            name: "ExternalDependenciesTests",
            dependencies: [
                "ComposableArchitectureApp",
                "LoggerApp",
                "FirebaseApp",
            ]
        ),
    ]
)

