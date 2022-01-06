//
//  EditViewController.swift
//  Algomukja
//
//  Created by 김수경 on 2021/12/24.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tf_material: UITextView!
    
    @IBOutlet weak var btn_send: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UISetting()
        setKeyboardObserver()
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


