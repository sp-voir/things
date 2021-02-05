// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Paywall",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Paywall",
            targets: ["Paywall"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../Modules/Views"),
        .package(path: "../Services/RemoteConfiguration"),
        .package(path: "../Services/InAppPurchases"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Paywall",
            dependencies: [
                .product(
                    name: "Views",
                    package: "Views"
                ),
                .product(
                    name: "RemoteConfiguration",
                    package: "RemoteConfiguration"
                ),
                .product(
                    name: "InAppPurchases",
                    package: "InAppPurchases"
                )
            ]
        ),
        .testTarget(
            name: "PaywallTests",
            dependencies: ["Paywall"]),
    ]
)
