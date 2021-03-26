// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Welcome",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Welcome",
            targets: ["Welcome"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../Modules/ExternalDependencies"),
        .package(path: "../Modules/SignIn"),
        .package(path: "../Modules/SignUp"),
        .package(path: "../Modules/Core"),
        .package(path: "../Modules/Services/Authentication"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Welcome",
            dependencies: [
                .product(
                    name: "ComposableArchitectureApp",
                    package: "ExternalDependencies"
                ),
                .product(
                    name: "SignIn",
                    package: "SignIn"
                ),
                .product(
                    name: "SignUp",
                    package: "SignUp"
                ),
                .product(
                    name: "Authentication",
                    package: "Authentication"
                ),
            ]
        ),
        .testTarget(
            name: "WelcomeTests",
            dependencies: ["Welcome"]),
    ]
)
