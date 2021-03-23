// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "PointInPolygon",
    products: [
        .library(
            name: "PointInPolygon",
            targets: ["PointInPolygon"])
    ],
    targets: [
        .target(
            name: "PointInPolygon"),
        .testTarget(
            name: "PointInPolygonTests",
            dependencies: ["PointInPolygon"])
    ]
)
