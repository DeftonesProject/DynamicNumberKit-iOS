// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GETSms",
    platforms: [
           .iOS(.v14),
       ],
    products: [
        .library(
            name: "GETSms",
            targets: ["GETSms"]),
    ],

    dependencies: [
        .package(url: "https://github.com/inapps-io/UserAcquisition.git", branch: "master"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.1"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "3.0.0"),
    ],
    
    targets: [
        .target(
            name: "GETSms",
            dependencies: [
                .product(name: "UserAcquisition", package: "UserAcquisition"),
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "KeychainAccess", package: "KeychainAccess"),
            ]
        )
    ]
)
