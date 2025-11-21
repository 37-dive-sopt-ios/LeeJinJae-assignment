//
//  RegisterRequest.swift
//  sopt-37th-practice04
//
//  Created by JIN on 11/8/25.
//

import UIKit

/// 유저 등록 API
struct RegisterRequest: Encodable {
    let username: String
        let password: String
        let name: String
        let email: String
        let age: Int
}
