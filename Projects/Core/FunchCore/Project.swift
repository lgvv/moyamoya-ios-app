import ProjectDescription

let project = Project(
    name: "FunchCore",
    targets: [
        .target(
            name: "FunchCore",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.FunchCore",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: []
        ),
        .target(
            name: "FunchCoreTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.FunchCoreTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "FunchCore")]
        ),
    ]
)
