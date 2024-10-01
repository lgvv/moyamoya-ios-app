import ProjectDescription

let project = Project(
    name: "MBTIBoardFeature",
    targets: [
        .target(
            name: "MBTIBoardFeature",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.MBTIBoardFeature",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "FunchNetworking", path: "../../Core/FunchNetworking"),
                .project(target: "FunchCore", path: "../../Core/FunchCore"),
                .project(target: "UserDefaultClient", path: "../../Shared/UserDefaultClient"),
                .project(target: "Entity", path: "../../Shared/Entity")
            ]
        ),
        .target(
            name: "MBTIBoardFeatureTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.MBTIBoardFeatureTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "MBTIBoardFeature")]
        ),
    ]
)
