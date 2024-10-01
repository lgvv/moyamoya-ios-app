import ProjectDescription

let project = Project(
    name: "ProfileEditUI",
    targets: [
        .target(
            name: "ProfileEditUI",
            destinations: .iOS,
            product: .framework,
            bundleId: "funch.ProfileEditUI",
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
                .project(target: "DesignSystem", path: "../../Core/DesignSystem"),
                .project(target: "OpenURLClient", path: "../../Shared/OpenURLClient"),
                .project(target: "ProfileFeature", path: "../../Features/Profile"),
                .project(target: "SearchSubwayStationFeature", path: "../../Features/SearchSubwayStation"),
                .project(target: "Coordinator", path: "../Coordinator")
                
            ]
        ),
        .target(
            name: "ProfileEditUITests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "funch.ProfileEditUITests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "ProfileEditUI")]
        ),
    ]
)
