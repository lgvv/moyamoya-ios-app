import ProjectDescription

let project = Project(
    name: "UserDefaultClient",
    targets: [
        .target(
            name: "UserDefaultClient",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.UserDefaultClient",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "FunchCore", path: "../../Core/FunchCore"),
                .project(target: "Entity", path: "../Entity")
            ]
        ),
        .target(
            name: "OpenURLClientTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.UserDefaultClientTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "UserDefaultClient")]
        ),
    ]
)
