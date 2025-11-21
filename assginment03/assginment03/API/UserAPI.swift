
//
//  UserAPI.swift
//  Seminar04
//
//  Created by 이명진 on 10/30/25.
//

import Foundation

/// User 관련 API 엔드포인트
/// Moya의 TargetType 과 비슷하게 구현함
 enum UserAPI {
    case register(RegisterRequest)           // POST /api/v1/users - 회원가입
    case login(LoginRequest)                 // POST /api/v1/auth/login - 로그인
    case getUser(id: Int)
    case updateUser(id: Int, UpdateUserRequest)
    case deleteUser(id: Int)
}

extension UserAPI: TargetType {

    /// 기본 URL
    public var baseURL: String {
        return Environment.baseURL
    }

    /// API 경로
    public var path: String {
        switch self {
        case .register:
            return "/api/v1/users"
        case .login:
            return "/api/v1/auth/login"
        case .getUser(let id):
            return "/api/v1/users/\(id)"
        case .updateUser(let id, _):
            return "/api/v1/users/\(id)"
        case .deleteUser(let id):
            return "/api/v1/users/\(id)"
        }
    }

    /// The HTTP method used in the request.
    var method: HTTPMethod {
        switch self {
        case .register:
            return .post
        case .login:
            return .post
        case .getUser:
            return .get
        case .updateUser:
            return .patch
        case .deleteUser:
            return .delete
        }
    }

    /// The type of HTTP task to be performed.
    public var task: HTTPTask {
        switch self {
        case .register(let request):
            // JSON 인코딩 가능한 객체를 바디로 전송
            return .requestJSONEncodable(request)

        case .login(let request):
            // JSON 인코딩 가능한 객체를 바디로 전송
            return .requestJSONEncodable(request)

        case .getUser:
            return .requestPlain

        case .updateUser(_, let request):
            // JSON 인코딩 가능한 객체를 바디로 전송
            return .requestJSONEncodable(request)

        case .deleteUser:
            return .requestPlain
        }
    }

    /// 헤더 (Moya와 동일 - 필요시 오버라이드)
    public var headers: [String: String]? {
        // Content-Type은 Task에서 자동 설정되므로 여기서는 nil 반환
        return nil
    }
}

// MARK: - Convenience Methods

extension UserAPI {
    /// 회원가입 API 요청 헬퍼
     static func performRegister(
        username: String,
        password: String,
        name: String,
        email: String,
        age: Int,
        provider: NetworkProviding = NetworkProvider()
    ) async throws -> UserResponse {
        let request = RegisterRequest(
            username: username,
            password: password,
            name: name,
            email: email,
            age: age
        )
        // BaseResponse로 감싸진 응답 디코딩
        let response: BaseResponse<UserResponse> = try await provider.request(UserAPI.register(request))
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }

    /// 로그인 API 요청 헬퍼
        static func performLogin(
        username: String,
        password: String,
        provider: NetworkProviding = NetworkProvider()
    ) async throws -> LoginResponse {
        let request = LoginRequest(username: username, password: password)
        // BaseResponse로 감싸진 응답 디코딩
        let response: BaseResponse<LoginResponse> = try await provider.request(UserAPI.login(request))
        guard let data = response.data else {
            throw NetworkError.noData
        }

        return data
    }

    static func performGetUser(
        id: Int,
        provider: NetworkProviding = NetworkProvider()
    ) async throws -> UserResponse {
        // BaseResponse로 감싸진 응답 디코딩
        let response: BaseResponse<UserResponse> = try await provider.request(UserAPI.getUser(id: id))
        guard let data = response.data else {
            throw NetworkError.noData
        }

        return data
    }

    static func performUpdateUser(
        id: Int,
        name: String?,
        email: String?,
        age: Int?,
        provider: NetworkProviding = NetworkProvider()
    ) async throws -> UserResponse {
        let request = UpdateUserRequest(name: name, email: email, age: age)
        // BaseResponse로 감싸진 응답 디코딩
        let response: BaseResponse<UserResponse> = try await provider.request(UserAPI.updateUser(id: id, request))
        guard let data = response.data else {
            throw NetworkError.noData
        }

        return data
    }

    static func performDeleteUser(
        id: Int,
        provider: NetworkProviding = NetworkProvider()
    ) async throws -> String {
        // BaseResponse로 감싸진 응답 디코딩
        let response: BaseResponse<DeleteUserResponse?> = try await provider.request(UserAPI.deleteUser(id: id))

        return response.message ?? "회원탈퇴가 완료되었습니다."
    }

}
