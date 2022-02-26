//
//  SearchRequest.swift
//  Algomukja
//
//  Created by 김수경 on 2022/02/25.
//

import Foundation

struct SearchRequest: Codable{
    var keyword: String
    var start: Int
    var limit: Int
}
