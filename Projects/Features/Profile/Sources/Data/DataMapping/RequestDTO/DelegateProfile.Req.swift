import FunchNetworking

extension RequestDTO {
    struct DeleteProfile: Requestable {
        
        var profileId: String
        
        init(query: DeleteProfileQuery) {
            profileId = query.profileId
        }
        
        var path: String {
            "\(profileId)"
        }
    }
}
