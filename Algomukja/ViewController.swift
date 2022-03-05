//
//  ViewController.swift
//  Algomukja
//
//  Created by 김수경 on 2021/11/09.
//

import UIKit
import SwiftyGif
class ViewController: UIViewController {

    let logoAnimationView = splashAnimationView()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          view.addSubview(logoAnimationView)
          logoAnimationView.pinEdgesToSuperView()
          logoAnimationView.logoGifImageView.delegate = self
      }
      
      override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          logoAnimationView.logoGifImageView.startAnimatingGif()
          
        
      }

  }

  extension ViewController: SwiftyGifDelegate {
      func gifDidStop(sender: UIImageView) {
          logoAnimationView.isHidden = true
          self.dismiss(animated: false, completion: {
              let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
              guard let VC = storyboard.instantiateViewController(identifier: "TabBarViewController") as? TabBarViewController else {
                  print("Controller not found")
                  return
              }
              VC.modalPresentationStyle = .overFullScreen
              self.present(VC, animated: false, completion: nil)
          })
          
         
      }
  }
