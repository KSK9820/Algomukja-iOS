//
//  ProductResponse.swift
//  Algomukja
//
//  Created by 김수경 on 2022/02/21.
//

import Foundation

struct ProductResponse: Codable{
    var code: String
    var success: Bool
    var payload: [Payload]
}

struct Payload: Codable{
    var id: Int
    var name: String
    var level: [Int]
    var finalLevel: Int
    var materials: [Materials]
    var image: String
    var isAccurate: Bool
}

struct Materials: Codable{
    var id: Int
    var name: String
    var level: Int
    var description: String
}
