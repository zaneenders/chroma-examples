// swift-tools-version: 6.4
import PackageDescription

let demos = [
  "FallingBlocksDemo", "ChatDemo", "ImageDemo", "SpreadsheetDemo", "BreakoutDemo", "TextEditingDemo", "LifeDemo",
]
let package = Package(
  name: "ChromaExamples",
  platforms: [.macOS(.v27)],
  products: demos.map { .executable(name: $0, targets: [$0]) },
  dependencies: [
    .package(
      url: "https://github.com/zaneenders/chroma.git",
      revision: "e46e475"
    )
  ],
  targets: demos.map {
    .executableTarget(
      name: $0,
      dependencies: [
        .product(name: "Chroma", package: "chroma"),
        .product(name: "ChromaApp", package: "chroma"),
      ]
    )
  } + [
    .testTarget(
      name: "DemoContentTests",
      dependencies: demos.map { .byName(name: $0) } + [
        .product(name: "ChromaTesting", package: "chroma")
      ]
    )
  ]
)
