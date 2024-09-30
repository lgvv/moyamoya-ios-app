import ProjectDescription

let project = Project(
    name: "ThirdParty",
    packages: [
        .remote(url: "https://github.com/airbnb/lottie-spm.git", requirement: .upToNextMajor(from: "4.4.1")),
        .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0.3")),
        .remote(url: "https://github.com/fermoya/SwiftUIPager.git", requirement: .upToNextMajor(from: "2.5.0"))
    ],
    targets: [
        .target(
            name: "ThirdParty",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.ThirdParty",
            infoPlist: .default,
            dependencies: [
                .package(product: "Lottie"),
                .package(product: "Moya"),
                .package(product: "SwiftUIPager")
            ]
        )
    ]
)
