// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkLayer",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NetworkLayer",
            targets: ["NetworkLayer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/mxcl/PromiseKit", "8.1.1" ..< "9.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NetworkLayer",
            dependencies: ["PromiseKit"]),
        .testTarget(
            name: "NetworkLayerTests",
            dependencies: ["NetworkLayer"]),
    ]
)
