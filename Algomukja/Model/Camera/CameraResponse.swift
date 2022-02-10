//
//  CameraResponse.swift
//  Algomukja
//
//  Created by 김수경 on 2022/01/28.
//

import Foundation


struct CameraResponse: Codable{
    var version: String
    var requestId: String
    var timestamp: Int64
    var images: [ImageResponse]
    
//    init(){
//        self.init(version: "", requestId: "", timestamp: 0, images: [ImageResponse(uid: "", name: "", inferResult: "", message: "", validationResult: validation(result: ""), fields: [field(valueType: "", boundingPoly: vertice(vertices: [location(x: 0, y: 0)]), inferText: "", inferConfidence: 0, type: "", lineBreak: true)])])
//    }
//
//    init(version: String, requestId: String, timestamp: Int64, images: [ImageResponse]){
//        self.version = version
//        self.requestId = requestId
//        self.timestamp = timestamp
//        self.images = images
//    }
}

struct ImageResponse: Codable{
    var uid: String
    var name: String
    var inferResult: String
    var message: String
    var validationResult: validation
    var fields: [field]
    
//    init(){
//        self.init(uid: "", name: "", inferResult: "", message: "", validationResult: validation(result: ""), fields: [field(valueType: "", boundingPoly: vertice(vertices: [location(x: 0, y: 0)]), inferText: "", inferConfidence: 0, type: "", lineBreak: true)])
//    }
//  
//    init(uid: String, name: String, inferResult: String, message: String, validationResult: validation, fields: [field]){
//        self.uid = uid
//        self.name = name
//        self.inferResult = inferResult
//        self.message = message
//        self.validationResult = validationResult
//        self.fields = fields
//    }
}

struct validation: Codable{
    var result: String
    
    init(){
        self.init(result: "")
    }
  
    init(result: String){
        self.result = result
    }
}

struct field: Codable{
    var valueType: String
    var boundingPoly: vertice
    var inferText: String
    var inferConfidence: Float
    var type: String
    var lineBreak: Bool
    
    
    init(){
        self.init(valueType: "", boundingPoly: vertice(vertices: [location(x: 0, y: 0)]), inferText: "", inferConfidence: 0, type: "", lineBreak: true)
    }
  
    init(valueType: String, boundingPoly: vertice, inferText: String, inferConfidence: Float, type: String, lineBreak: Bool){
        self.valueType = valueType
        self.boundingPoly = boundingPoly
        self.inferText = inferText
        self.inferConfidence = inferConfidence
        self.type = type
        self.lineBreak = lineBreak
    }
}

struct vertice: Codable{
    var vertices: [location]
 
    
    init(){
        self.init(vertices: [])
    }
  
    init(vertices: [location]){
        self.vertices = vertices
    }
}

struct location: Codable{
    var x: Int
    var y: Int


    init(){
        self.init(x: 0, y: 0)
    }
    
    init(x: Int, y: Int){
        self.x = x
        self.y = y
    }
}
