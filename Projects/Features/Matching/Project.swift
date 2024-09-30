import ProjectDescription

let project = Project(
    name: "MatchingFeature",
    targets: [
        .target(
            name: "MatchingFeature",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.MatchingFeature",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "FunchNetworking", path: "../../Core/FunchNetworking"),
                .project(target: "FunchCore", path: "../../Core/FunchCore"),
                .project(target: "Entity", path: "../../Shared/Entity")
            ]
        ),
        .target(
            name: "MatchingFeatureTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.MatchingFeatureTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "MatchingFeature")]
        ),
    ]
)
