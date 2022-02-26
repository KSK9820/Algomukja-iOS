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
            
            
            var formData = [MultipartFormData]()
            var fileName = "\(request.images[0]).jpg"
            fileName = fileName.replacingOccurrences(of: " ", with: "_")
            
//            for imageData in request.images {
//
//                print("images name \(fileName)")
//                formData.append(MultipartFormData(provider: .data(imageData.data), name: "images.data", fileName: fileName, mimeType: "image/jpeg"))
//            }
//
//            let parameter: [String: Any] = [
//                "format": request.images[0].format,
//                "name": request.images[0].name,
//                "data": formData,
//                "url": "https://www.google.com/url?sa=i&url=http%3A%2F%2Fm.blog.naver.com%2Fnakscho%2F221429480925&psig=AOvVaw2TSht9btu9qxtp7FVzJRAI&ust=1645029747530000&source=images&cd=vfe&ved=0CAgQjRxqFwoTCMiVlcGTgvYCFQAAAAAdAAAAABAD"
//            ]
//
//            for (key, value) in parameter {
//                if key == "data"{
//                    formData.append(MultipartFormData(provider: .data(request.images[0].data), name: fileName, fileName: fileName, mimeType: "image/jpeg"))
//                } else{
//                    formData.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key))
//                    print("\(key) : \(value)")
//
//                }
//
//
//                var formDatas = [MultipartFormData]()
//            let parameters: [String : Any] = [
//                "images": [
//                    formData
//                ],
//                "lang": request.lang,
//                "requestId": request.requestId,
//                "resultType": request.resultType,
//                "timestamp": request.timestamp,
//                "version": request.version
//            ]
//
//
//            for (key, value) in parameters {
//
//                    formDatas.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key))
//                    print("\(key) : \(value)")
//
//                }
//
//                                    }
//
//            return .uploadMultipart(formData)
            
            
//
//            var formData = [MultipartFormData]()
//            let ocrImage = "\(request.images[0].name).jpg".replacingOccurrences(of: " ", with: "_")
//            var imageToData = MultipartFormData(provider: .data(request.images[0].data), name: ocrImage, fileName: ocrImage, mimeType: "image/jpeg")
//            formData.append(MultipartFormData(provider: .data(request.images[0].data), name: ocrImage, fileName: ocrImage, mimeType: "image/jpeg"))
//
//            formData.append(MultipartFormData(provider: .data("\(request.lang)".data(using: .utf8)!), name: "lnag"))
//
//            let parameters: [String : Any] = [
//                "images": [
//                    [
//                        "format": request.images[0].format,
//                        "name": request.images[0].name,
//                        //"data": request.images[0].data,
//                        "url": "https://www.google.com/url?sa=i&url=http%3A%2F%2Fm.blog.naver.com%2Fnakscho%2F221429480925&psig=AOvVaw2TSht9btu9qxtp7FVzJRAI&ust=1645029747530000&source=images&cd=vfe&ved=0CAgQjRxqFwoTCMiVlcGTgvYCFQAAAAAdAAAAABAD"
//                    ]
//                ],
//                "lang": request.lang,
//                "requestId": request.requestId,
//                "resultType": request.resultType,
//                "timestamp": request.timestamp,
//                "version": request.version
//            ]
//
//            for (key, value) in parameters {
//                formData.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key))
//
//                print("\(key) : \(value)")
//            }
//
//            print(formData)
//
//            let base64str = convertImageToBase64String(img: request.images[0].data)
            
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

//            return .uploadMultipart(formData)
        }
    }

    var headers: [String:String]?{
        return ["Content-Type": "application/json", "X-OCR-SECRET": "c3JhcWJsZXFhc1FUQUhweGZScmNjZUxOcmV2ZnBnUmQ="]
        //"dUV6UXdyR3l1a3pCWHdCU2hXc1pNa2tqVUdLTkpBaEc="]
    }
}
