import ProjectDescription

let workspace = Workspace(
    name: "funch-workspace",
    projects: [
        "Projects/Core/FunchCore",
        "Projects/Core/ThirdParty",
        "Projects/Core/FunchNetworking",
        "Projects/Core/DesignSystem",
        
        "Projects/Shared/Entity",
        "Projects/Shared/OpenURLClient",
        "Projects/Shared/UserDefaultClient",
        
        "Projects/Features/Profile",
        "Projects/Features/Matching",
        "Projects/Features/SearchSubwayStation",
        "Projects/Features/MBTIBoard",
        
        "Projects/UI/Splash",
        "Projects/UI/Onboarding",
        "Projects/UI/EasterEgg",
        "Projects/UI/MBTIBoard",
        "Projects/UI/MatchResult",
        "Projects/UI/Profile",
        "Projects/UI/MultiProfile",
        "Projects/UI/ProfileEdit",
        "Projects/UI/Home",
        
        "Projects/App"
        
    ]
)
