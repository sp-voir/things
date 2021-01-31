// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Views",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Views",
            targets: ["Views"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../Modules/Extensions"),
        .package(path: "../Modules/Resources"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Views",
            dependencies: [
                .product(
                    name: "Extensions",
                    package: "Extensions"
                ),
                .product(
                    name: "Resources",
                    package: "Resources"
                ),
            ]
        ),
        .testTarget(
            name: "ViewsTests",
            dependencies: ["Views"]),
    ]
)
