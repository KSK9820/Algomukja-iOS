//
//  MaterialResponse.swift
//  Algomukja
//
//  Created by 김수경 on 2022/02/26.
//

import Foundation

struct MaterialResponse: Codable{
    var code: String
    var success: Bool
    var payload: materialPayload
}

struct materialPayload: Codable{
    var `internal`: [Internal]
    var external: [External]
}

struct Internal: Codable{
    var id: Int
    var name: String
    var level: Int
    var description: String
}

struct External: Codable{
    var name: String
    var description: String
}
