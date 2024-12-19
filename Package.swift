// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "JackoboCapacitorApplePay",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "JackoboCapacitorApplePay",
            targets: ["CapacitorApplePayPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "CapacitorApplePayPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/CapacitorApplePayPlugin"),
        .testTarget(
            name: "CapacitorApplePayPluginTests",
            dependencies: ["CapacitorApplePayPlugin"],
            path: "ios/Tests/CapacitorApplePayPluginTests")
    ]
)