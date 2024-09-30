import ProjectDescription

let project = Project(
    name: "FunchNetworking",
    targets: [
        .target(
            name: "FunchNetworking",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.FunchNetworking",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "FunchCore", path: "../FunchCore"),
                .package(product: "Moya"),
                .package(product: "Alamofire")
            ]
        ),
        .target(
            name: "FunchNetworkingTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.FunchNetworkingTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "FunchNetworking")]
        ),
    ]
)
