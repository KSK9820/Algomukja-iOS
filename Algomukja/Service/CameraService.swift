//
//  CameraService.swift
//  Algomukja
//
//  Created by 김수경 on 2022/01/24.
//

import Foundation
import Moya

enum CameraService {
    case postOCR(ocr: CameraRequest)
}

extension CameraService: TargetType {

    
    var baseURL: URL{
        guard let url = URL(string: Config.clova_ocr) else{
            fatalError()
        }
        return url
    }


    var path: String{
        switch self{
        case .postOCR(_):
            return ""
        }
    }

    var method: Moya.Method{
        switch self {
        case .postOCR:
            return .post
        }
    }

    var task: Task{
        switch self{
        case .postOCR(let request):
            return .requestParameters(
                parameters: [
                    "images": [
                        ["format": request.images[0].format,
                         "name": request.images[0].name,
                         "data": request.images[0].data,
                         "url": nil]
                    ],
                    "lang": request.lang,
                    "requestId": request.requestId,
                    "resultType": request.resultType,
                    "timestamp": request.timestamp,
                    "version": request.version
                ],
                encoding: JSONEncoding.default)
        }
    }

    var headers: [String:String]?{
        return ["Content-Type": "application/json", "X-OCR-SECRET":
                    "WHlxTW54d1J3c0hFVlNib1RIUGZMZ2pna3V4Wnl6d00="]
        //"dUV6UXdyR3l1a3pCWHdCU2hXc1pNa2tqVUdLTkpBaEc="]
    }
}
