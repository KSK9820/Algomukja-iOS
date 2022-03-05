//
//  SplashAnimationView.swift
//  Algomukja
//
//  Created by 김수경 on 2022/03/05.
//

import Foundation
import UIKit
import SwiftyGif


class splashAnimationView: UIView{
    let logoGifImageView: UIImageView = {
        guard let gifImage = try? UIImage(gifName: "splash.gif") else {
            return UIImageView()
        }
        return UIImageView(gifImage: gifImage, loopCount: 1)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor(white: 246.0 / 255.0, alpha: 1)
        addSubview(logoGifImageView)
        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
        logoGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoGifImageView.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        logoGifImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
    }
}
