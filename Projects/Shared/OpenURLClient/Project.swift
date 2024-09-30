import ProjectDescription

let project = Project(
    name: "OpenURLClient",
    targets: [
        .target(
            name: "OpenURLClient",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.OpenURLClient",
            sources: ["Sources/**"],
            dependencies: []
        ),
        .target(
            name: "OpenURLClientTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.OpenURLClientTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "OpenURLClient")]
        ),
    ]
)
