//
//  Extensions.swift
//  Algomukja
//
//  Created by 김수경 on 2021/12/01.
//

import Foundation
import UIKit

extension UIView {
    
    func makeRoundView(radius: Int){
            self.layer.cornerRadius = CGFloat(radius)
            self.clipsToBounds = true
        }
    
    func makeBorder(colorName: String){
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(named: colorName)!.cgColor
        self.clipsToBounds = true
    }
    

    func setViewShadow(backView: UIView, colorName: String) {
            backView.layer.masksToBounds = true
            backView.layer.cornerRadius = 10
            //backView.layer.borderWidth = 1
            
            layer.shadowColor = UIColor(named: colorName)!.cgColor
            layer.masksToBounds = false
            layer.shadowOpacity = 0.6
            layer.shadowOffset = CGSize(width: -2, height: 3)
            layer.shadowRadius = 4
        }
    
    
    
}

extension UIImageView{
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
      }
}
