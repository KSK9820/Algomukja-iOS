//
//  MaterialRequest.swift
//  Algomukja
//
//  Created by 김수경 on 2022/02/26.
//

import Foundation

struct MaterialRequest: Codable{
    var keyword: String
    var start: Int
    var limit: Int
}
