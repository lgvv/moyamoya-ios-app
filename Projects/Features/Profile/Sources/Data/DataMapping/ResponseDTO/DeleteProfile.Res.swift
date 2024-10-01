import FunchNetworking

extension ResponseDTO {
    struct DeleteProfile: Respondable {
        var status: String
        var message: String
        var data: String
    }
}

extension ResponseDTO.DeleteProfile {
    func toDomain() -> String {
        return data
    }
}
