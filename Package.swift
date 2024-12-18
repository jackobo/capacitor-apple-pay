// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "JackoboCapacitorApplePay",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "JackoboCapacitorApplePay",
            targets: ["CapacitorApplePayPluginPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "CapacitorApplePayPluginPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/CapacitorApplePayPluginPlugin"),
        .testTarget(
            name: "CapacitorApplePayPluginPluginTests",
            dependencies: ["CapacitorApplePayPluginPlugin"],
            path: "ios/Tests/CapacitorApplePayPluginPluginTests")
    ]
)