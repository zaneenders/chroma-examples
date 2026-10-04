// swift-tools-version: 6.4
import Foundation
import PackageDescription

let demos = [
  "FallingBlocksDemo", "ChatDemo", "ImageDemo", "SpreadsheetDemo",
  "BreakoutDemo", "TextEditingDemo", "LifeDemo", "StressExample", "MarkdownDemo",
]
let package = Package(
  name: "ChromaExamples",
  platforms: [.macOS(.v27)],
  products: demos.map { .executable(name: $0, targets: [$0]) },
  dependencies: [
    ProcessInfo.processInfo.environment["CHROMA_LOCAL_PATH"].map { .package(path: $0) }
      ?? .package(path: "../chroma")
  ],
  targets: demos.map {
    .executableTarget(
      name: $0,
      dependencies: [
        .product(name: "Chroma", package: "chroma"),
        .product(name: "ChromaApp", package: "chroma"),
      ] + ($0 == "MarkdownDemo" ? [.product(name: "ChromaMarkdown", package: "chroma")] : [])
    )
  } + [
    .testTarget(
      name: "MarkdownDemoTests",
      dependencies: ["MarkdownDemo", .product(name: "ChromaTesting", package: "chroma")]
    ),
    .testTarget(
      name: "DemoContentTests",
      dependencies: demos.map { .byName(name: $0) } + [
        .product(name: "ChromaTesting", package: "chroma")
      ]
    ),
  ]
)
