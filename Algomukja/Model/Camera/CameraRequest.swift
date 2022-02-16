//
//  CameraRequest.swift
//  Algomukja
//
//  Created by 김수경 on 2022/01/24.
//

import Foundation
import Moya

struct CameraRequest: Codable{
    var images: [clova_image]
    var lang: String //= "ko"
    var requestId: String //= "string"
    var resultType: String
    var timestamp: Int64 //= "string"
    var version: String //= "V2"
    
    init(){
        self.init(images: [], lang: "", requestId: "", resultType: "", timestamp: 0, version: "")
    }
    
    init(images: [clova_image], lang: String, requestId: String, resultType: String, timestamp: Int64, version: String){
        self.images = images
        self.lang = lang
        self.requestId = requestId
        self.resultType = resultType
        self.timestamp = timestamp
        self.version = version
    }
    
}

struct clova_image: Codable{
    var format: String
    var name: String
    var data: String
    var url: String
        
    init(){
        self.init(format: "", name: "", data: "", url: "")
    }
  
    init(format: String, name: String, data: String, url: String){
        self.format = format
        self.name = name
        self.data = data
        self.url = url
    }
}
