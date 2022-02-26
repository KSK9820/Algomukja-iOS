//
//  ProductService.swift
//  Algomukja
//
//  Created by 김수경 on 2022/02/21.
//

import Foundation
import Moya

enum ProductService {
    case getProduct(product: ProductRequest)
    
}

extension ProductService: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.api) else{
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self{
        case .getProduct:
           return "/api/v1/product/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProduct:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .getProduct(let request):
            return .requestParameters(parameters: ["type": request.type, "start": request.start, "limit": request.limit], encoding: URLEncoding.default)
            
        }
    }
    
    var headers: [String : String]? {
        .none
    }
    
}
