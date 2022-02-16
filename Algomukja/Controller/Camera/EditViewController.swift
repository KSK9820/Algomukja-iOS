//
//  EditViewController.swift
//  Algomukja
//
//  Created by 김수경 on 2021/12/24.
//

import UIKit
import Foundation
import Moya



class EditViewController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tf_material: UITextView!
    
    @IBOutlet weak var btn_send: UIButton!
    
    let provider = MoyaProvider<CameraService>()
    var request = CameraRequest()
    var imageRequest = [clova_image]()
    var text_material = [field]()
    
    var ocrImage: UIImage!
    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UISetting()
        setKeyboardObserver()
        
        let timestamp = Date().currentTimeMillis()
        let base64str = ocrImage.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        
        request = CameraRequest(images: [clova_image(format: "jpg", name: String(timestamp), data: base64str, url: "http://image.nongshim.com/non/pro/bong_2.jpg")], lang: "ko", requestId: "e36ead3ac71f45d9a5c8d8da285818a7", resultType: "string", timestamp: timestamp ,version: "V2")
     
        postOCR(data: request)
 
    }
    
    func UISetting(){
        self.view.clipsToBounds = true
        self.view.layer.cornerRadius = 15
        self.view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        topView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        topView.makeRoundView(radius: 3)
        tf_material.layer.borderColor = UIColor(named: "green1")!.cgColor
        tf_material.layer.borderWidth = 1
        tf_material.makeRoundView(radius: 15)
        btn_send.setViewShadow(backView: btn_send, colorName: "200", width: -2, height: 2)
//        btn_send.makeRoundView(radius: 15)
    }

    func textSetting(text: [field]){
        //결과 수정해서 post할 때 수정된 string -> array로 변환 필요

        var material: [String] = []
        var string = ""
        
        for i in 0..<text.count {
            //제품명과 식품유형을 제외
            if text[i].inferText == "제품명" || text[i].inferText == "식품유형"{
                continue
            }else if text[i].inferText == "유통기한"{
                break
//            }else if text[i].inferText == "원재료명" {
//                material.append(text[i].inferText)
//                string += text[i].inferText + " "
            }else{
                material.append(text[i].inferText)
                string += text[i].inferText + " "
            }
           
        }
        
        tf_material.delegate = self
//        print(string)
        tf_material.text = string
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }

    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(EditViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(EditViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
          if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                  let keyboardRectangle = keyboardFrame.cgRectValue
                  let keyboardHeight = keyboardRectangle.height
              
              
              UIView.animate(withDuration: 1) { [self] in
                  if self.view.window?.frame.origin.y == 0 {
                      self.view.window?.frame.origin.y -= keyboardHeight    
                  }
              }

            
      }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.window?.frame.origin.y != 0 {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardRectangle = keyboardFrame.cgRectValue
                    let keyboardHeight = keyboardRectangle.height
                UIView.animate(withDuration: 1) {
                    self.view.window?.frame.origin.y += keyboardHeight
                }
            }
        }
    
    }
   

}

extension EditViewController{
    @IBAction func postButton(_ sender: Any) {
        //print(self.tf_material.text.components(separatedBy: ", "))
        
        getResult()
        
      
        
        
    }
}


extension EditViewController{
    func postOCR(data: CameraRequest){
        provider.request(.postOCR(ocr: request)){ [weak self] result in
//                guard let self = self else {return}
                
                switch result {
                case .success(let response):
                    do{
//                        print("***result: \(try response.mapJSON())")
                        let datas = try JSONDecoder().decode(CameraResponse.self, from: response.data)
                    
                        self!.text_material = datas.images[0].fields
                        
                     
                        DispatchQueue.main.async{ [self] in
                            self!.textSetting(text: self!.text_material)
                        }
                       
                    }catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                    
                case .failure(let error):
                    
                    print("***error: \(error.localizedDescription)")
                }
                
                
            }
        }
    
    func getResult(){
        let storyboard = UIStoryboard(name: "Camera", bundle: nil)
        guard let VC = storyboard.instantiateViewController(identifier: "SearchResultViewController") as? SearchResultViewController else {
            print("Controller not found")
            return
        }
        VC.modalPresentationStyle = .overFullScreen
       
        self.present(VC, animated: true, completion: nil)
    }
}
