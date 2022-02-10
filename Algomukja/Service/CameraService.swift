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
            
//            var formData = [MultipartFormData]()
//            let ocrImage = "\(request.images).jpg".replacingOccurrences(of: " ", with: "_")
//            print("Image name \(request.images[0].data)")
//
//            formData.append(MultipartFormData(provider: .data(request.images[0].data!), name: ocrImage, fileName: ocrImage, mimeType: "image/jpeg"))
            
//            var totalData = CameraRequest(images: [clova_image(format: "jpg", name: "name", data: request.images[0].data!, url: "http://image.nongshim.com/non/pro/bong_2.jpg")], lang: "ko", requestId: "string", timestamp: "string", version: "V2")
            
            
//            var a = CameraRequest(images: [clova_image(format: "jpg", name: "test", url: "http://image.nongshim.com/non/pro/bong_2.jpg")], lang: "ko", requestId: "string", timestamp: "string", version: "V2")
//            return .uploadMultipart(formData)
            
            
            
            //var url_test = CameraRequest()
            return .requestParameters(
                parameters: [
//                    "images": [
//                        ["format": request.images[0].format,
//                               "name": request.images[0].name,
//                               "data": nil,
//                               "url": request.images[0].url]
//                    ],
//                "lang": request.lang,
//                "requestId": request.requestId,
//                "resultType": request.resultType,
//                "timestamp": request.timestamp,
//                "version": request.version
                    "images": [[
                            "format": "jpg",
                            "name": "medium",
                            "url": "http://image.nongshim.com/non/pro/bong_2.jpg"
                        ]],
                        "lang": "ko",
                        "requestId": "f35224d739c94a2e9b11c994982d7c70",
                        "resultType": "string",
                        "timestamp": request.timestamp,
                        "version": "V2"
            ],
                encoding: JSONEncoding.default)
        }
    }

    var headers: [String:String]?{
        return ["Content-Type": "application/json", "X-OCR-SECRET": "dUV6UXdyR3l1a3pCWHdCU2hXc1pNa2tqVUdLTkpBaEc="]
    }
}
