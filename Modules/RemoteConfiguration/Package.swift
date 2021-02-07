// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RemoteConfiguration",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RemoteConfiguration",
            targets: ["RemoteConfiguration"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "../Modules/ExternalDependencies"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RemoteConfiguration",
            dependencies: [
                .product(
                    name: "LoggerApp",
                    package: "ExternalDependencies"
                ),
                .product(
                    name: "Firebase",
                    package: "ExternalDependencies"
                ),
                .product(
                    name: "CombineExtApp",
                    package: "ExternalDependencies"
                ),
            ]
        ),
//        .target(
//            name: "MyTargetName",
//            dependencies: [
//              // The product name you need. In this example, FirebaseAuth.
//              .product(name: "FirebaseRemoteConfig", package: "Firebase"),
//            ]
//        ),
        .testTarget(
            name: "RemoteConfigurationTests",
            dependencies: ["RemoteConfiguration"]),
    ]
)
