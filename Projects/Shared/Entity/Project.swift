import ProjectDescription

let project = Project(
    name: "Entity",
    targets: [
        .target(
            name: "Entity",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.Entity",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: []
        ),
        .target(
            name: "EntityTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "Entity")]
        ),
    ]
)
