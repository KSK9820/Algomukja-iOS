//
//  ItemInfoViewController.swift
//  Algomukja
//
//  Created by 김수경 on 2021/12/02.
//

import UIKit

class ItemInfoViewController: UIViewController {

    @IBOutlet weak var modalview: UIView!{
        didSet{
            modalview.setViewShadow(backView: modalview, colorName: "400")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundSetting()
    }
    
  
    func backgroundSetting(){
        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.view.isOpaque = true
    }
}
