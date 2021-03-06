// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Root",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Root",
            targets: ["Root"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../ExternalDependencies"),
        .package(path: "../Profile"),
        .package(path: "../Features/Welcome"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Root",
            dependencies: [
                .product(
                    name: "ComposableArchitectureApp",
                    package: "ExternalDependencies"
                ),
                .product(
                    name: "Profile",
                    package: "Profile"
                ),
                .product(
                    name: "Welcome",
                    package: "Welcome"
                ),
            ]
        ),
        .testTarget(
            name: "RootTests",
            dependencies: ["Root"]),
    ]
)
