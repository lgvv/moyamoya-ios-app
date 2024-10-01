import ProjectDescription

let project = Project(
    name: "SearchSubwayStationFeature",
    targets: [
        .target(
            name: "SearchSubwayStationFeature",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.SearchSubwayStationFeature",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "FunchNetworking", path: "../../Core/FunchNetworking"),
                .project(target: "FunchCore", path: "../../Core/FunchCore"),
                .project(target: "Entity", path: "../../Shared/Entity")
            ]
        ),
        .target(
            name: "SearchSubwayStationFeatureTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.SearchSubwayStationFeatureTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "SearchSubwayStationFeature")]
        ),
    ]
)
