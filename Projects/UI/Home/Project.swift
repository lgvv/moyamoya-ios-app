import ProjectDescription

let project = Project(
    name: "HomeUI",
    targets: [
        .target(
            name: "HomeUI",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.HomeUI",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "FunchCore", path: "../../Core/FunchCore"),
                .project(target: "DesignSystem", path: "../../Core/DesignSystem"),
                .project(target: "OpenURLClient", path: "../../Shared/OpenURLClient"),
                .project(target: "MatchingFeature", path: "../../Features/Matching"),
                .project(target: "ProfileFeature", path: "../../Features/Profile"),
                .project(target: "MBTIBoardFeature", path: "../../Features/MBTIBoard"),
                .project(target: "Coordinator", path: "../Coordinator")
            ]
        ),
        .target(
            name: "HomeUITests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.HomeUITests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "HomeUI")]
        ),
    ]
)
