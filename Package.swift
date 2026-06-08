// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "TimePicker",
  platforms: [
    .iOS("26.0")
  ],
  products: [
    .library(name: "TimePicker", targets: ["TimePicker"])
  ],
  targets: [
    .target(name: "TimePicker")
  ],
  swiftLanguageModes: [.v6]
)
