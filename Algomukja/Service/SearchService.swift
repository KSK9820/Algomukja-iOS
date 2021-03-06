//
//  SearchService.swift
//  Algomukja
//
//  Created by 김수경 on 2022/02/25.
//

import Foundation
import Moya

enum SearchService {
    case getSearch(search: SearchRequest)
    case getMaterial(request: MaterialRequest)
    case getRank

}

extension SearchService: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.api) else{
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self{
        case .getSearch:
           return "/api/v1/product/search"
        case .getMaterial(let request):
            return "api/v1/material/search"
        case .getRank:
            return "/api/v1/product/rank"
        }
        
        
    }
    
    var method: Moya.Method {
        switch self {
        case .getSearch, .getMaterial, .getRank:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .getSearch(let request):
            return .requestParameters(parameters: ["keyword": request.keyword, "start": request.start, "limit": request.limit], encoding: URLEncoding.default)
        case .getMaterial(let request):
//            return .requestPlain
            return .requestParameters(parameters: ["keyword": request.keyword, "start": request.start, "limit": request.limit], encoding: URLEncoding.default)
        case .getRank:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        .none
    }
    
}
