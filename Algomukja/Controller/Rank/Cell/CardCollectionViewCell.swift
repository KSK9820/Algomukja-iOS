//
//  CardCollectionViewCell.swift
//  Algomukja
//
//  Created by 김수경 on 2022/01/05.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    static var identifier = "CardCollectionViewCell"
    
    @IBOutlet weak var cardview: UIView!
    @IBOutlet weak var iv_item: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_manufacture: UILabel!
    
    @IBOutlet var level: [UIImageView]!
    @IBOutlet weak var iv_rank: UIImageView!
    @IBOutlet weak var lbl_rank: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UISetting()
        
    }
    
    func UISetting(){
//        cardview.backgroundColor = UIColor(named: "300")
        cardview.makeRoundView(radius: 20)
       
       
    }
    
    
    static func nib() -> UINib { return UINib(nibName: "CardCollectionViewCell", bundle: nil) }

    public func configure(with data: Card, indexpath: Int){
        let url = URL(string: data.photo)
        iv_item.load(url: url!)
        
        lbl_name.text = data.name
        lbl_manufacture.text = data.manufacture
        
        for i in 0..<6{
            if data.level[i] == 0 {
                level[i].setImageColor(color: UIColor(named: "400")!)
            }
        }
        iv_rank.setImageColor(color: UIColor(named: "level\(data.finallevel + 1)")!)
        lbl_rank.text = String(indexpath + 1)
        cardview.setViewShadow(backView: cardview, colorName: "level\(data.finallevel + 1)", width: -3, height: 1)
    }
  

}
