//
//  EditViewController.swift
//  Algomukja
//
//  Created by 김수경 on 2021/12/24.
//

import UIKit
import Foundation
import Moya

class EditViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tf_material: UITextView!
    
    @IBOutlet weak var btn_send: UIButton!
    
    let provider = MoyaProvider<CameraService>()
    var request = CameraRequest()
    var imageRequest = [clova_image]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UISetting()
        setKeyboardObserver()
        
        let timestamp = Date().currentTimeMillis()
        request = CameraRequest(images: [clova_image(format: "jpg", name: "medium", data: Data(), url: "http://image.nongshim.com/non/pro/bong_2.jpg")], lang: "ko", requestId: "e36ead3ac71f45d9a5c8d8da285818a7", resultType: "string", timestamp: timestamp ,version: "V2")
        
        print(request)
        
        
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

    func textSetting(){
        //OCR결과 tf_material에 넣기
        
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
                  self.view.window?.frame.origin.y -= keyboardHeight
                  //tf_material.setBottomInset(to: keyboardHeight)
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
    func postOCR(data: CameraRequest){
        provider.request(.postOCR(ocr: request)){ [weak self] result in
//                guard let self = self else {return}
                
                switch result {
                case .success(let response):
                    do{
                        print("***result: \(try response.mapJSON())")
                        
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
}
