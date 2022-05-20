// swift-tools-version: 5.6

import PackageDescription

let package = Package(
  name: "Readability",
  platforms: [
    .macOS(.v10_14),
    .iOS(.v12),
    .tvOS(.v12),
    .watchOS(.v5),
    .macCatalyst(.v14)
  ],
  products: [
    .library(
      name: "Readability",
      targets: ["Readability"]),
  ],
  dependencies: [
    .package(url: "https://github.com/wfreitag/syllable-counter-swift", branch: "master")
  ],
  targets: [
    .target(
      name: "Readability",
      dependencies: [
        .product(name: "SyllableCounter", package: "syllable-counter-swift")
      ]),
    .testTarget(
      name: "ReadabilityTests",
      dependencies: ["Readability"]),
  ]
)
