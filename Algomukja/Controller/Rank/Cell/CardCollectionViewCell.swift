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
//    @IBOutlet weak var lbl_manufacture: UILabel!
    
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

    public func configure(with data: Payload, indexpath: Int){
        let url = URL(string: Config.api + data.image)
        iv_item.load(url: url!)
        
        lbl_name.text = data.name
//        lbl_manufacture.text = data.manufacture
        
        
        for i in 0..<3{
            level[i].image = UIImage(named: "\(i + 1)단계(숫자없음흑백)")
        }
        for i in 3..<6{
            level[i].image = UIImage(named: "\(i + 2)단계(숫자없음흑백)")
        }

        for i in 0..<7{
            if data.level[i] == 1 {
                setImage(stage: i)
            }
        }
        
        iv_rank.setImageColor(color: UIColor(named: "level\(data.finalLevel)")!)
        if data.finalLevel == 4 && data.level[1] == 1{
            iv_rank.setImageColor(color: UIColor(named: "level4")!)
            cardview.setViewShadow(backView: cardview, colorName: "level4", width: -3, height: 1)
                
        }else if data.finalLevel == 4 && data.level[1] == 0 {
            iv_rank.setImageColor(color: UIColor(named: "level3")!)
            cardview.setViewShadow(backView: cardview, colorName: "level3", width: -3, height: 1)
                
        }else {
            iv_rank.setImageColor(color: UIColor(named: "level\(data.finalLevel)")!)
            cardview.setViewShadow(backView: cardview, colorName: "level\(data.finalLevel)", width: -3, height: 1)
                
        }
        lbl_rank.text = String(indexpath + 1)
        
    }
  
    
    
    func setImage(stage: Int){
        switch stage{
        case 0, 1, 2:
            level[stage].image = UIImage(named: "\(stage + 1)단계(숫자없음)")
        case 3:
            level[1].image = UIImage(named: "2단계(숫자없음)")
            level[2].image = UIImage(named: "3단계(숫자없음)")
        case 4, 5, 6:
            level[stage - 1].image = UIImage(named: "\(stage + 1)단계(숫자없음)")
        default:
            break
        }
    }

}
