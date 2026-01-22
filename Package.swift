// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "HW1-GameCore",
    platforms: [ .macOS(.v13) ],
    products: [
        .library(name: "GameCore", targets: ["GameCore"]),
    ],
    targets: [
        .target(name: "GameCore"),
    ]
)
