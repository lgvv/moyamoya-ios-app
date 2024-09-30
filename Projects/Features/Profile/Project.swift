import ProjectDescription

let project = Project(
    name: "ProfileFeature",
    targets: [
        .target(
            name: "ProfileFeature",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.ProfileFeature",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "FunchNetworking", path: "../../Core/FunchNetworking"),
                .project(target: "FunchCore", path: "../../Core/FunchCore"),
                .project(target: "Entity", path: "../../Shared/Entity")
            ]
        ),
        .target(
            name: "ProfileFeatureTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.ProfileFeatureTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "ProfileFeature")]
        ),
    ]
)
