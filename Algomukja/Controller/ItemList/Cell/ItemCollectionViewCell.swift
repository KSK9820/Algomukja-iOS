//
//  ItemCollectionViewCell.swift
//  Algomukja
//
//  Created by 김수경 on 2021/12/01.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemview: UIView!
    @IBOutlet weak var iv_item: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_level: UILabel!
    @IBOutlet var iv_level: [UIImageView]!
    @IBOutlet weak var lbl_caution: UILabel!
    
    static var identifier = "ItemCollectionViewCell"
    
    let level = ["", "비건", "락토 베지테리언", "오보 베지테리언", "락토오보 베지테리언", "페스코 베지테리언", "폴로 베지테리언", "플렉시테리언"]
    let caution = ["확인되지 않은 재료명이 있습니다. \n제조사에 문의 바랍니다.", "분석이 확실합니다!"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UISetting()
    }
    
    func UISetting(){
        self.contentView.makeRoundView(radius: 10)
        self.itemview.makeRoundView(radius: 10)
        setViewShadow(backView: itemview, colorName: "300", width: -1, height: 2)
        self.lbl_name.numberOfLines = 3
        self.lbl_name.sizeToFit()
        self.lbl_name.lineBreakMode = .byCharWrapping
        self.iv_item.widthAnchor.constraint(equalToConstant: screenWidth * 0.3).isActive = true
        
    }

    
    static func nib() -> UINib {
              return UINib(nibName: "ItemCollectionViewCell", bundle: nil)
       }
    
    
    
    public func configure(with item: Payload, indexpath: Int){
        
        let url = URL(string: Config.api + item.image)
        iv_item.load(url: url!)
        
        lbl_name.text = item.name
        if item.finalLevel == 4 && item.level[2] == 1{
            lbl_level.text = level[4]
        }else if item.finalLevel == 4 && item.level[2] == 0 {
            lbl_level.text = level[3]
        }else{
            lbl_level.text = level[item.finalLevel]
        }
        
        
        if item.isAccurate == false{
            lbl_caution.text = caution[0]
        }else{
            lbl_caution.text = caution[1]
        }

        for i in 0..<6{
            iv_level[i].image = UIImage(named: "\(i + 1)단계(숫자없음)")
        }

        for i in 0..<3{
            if item.level[i] == 0 {
                iv_level[i].image = UIImage(named: "\(i + 1)단계(숫자없음흑백)")
            }
        }
        for i in 4..<7{
            if item.level[i] == 0 {
                iv_level[i - 1].image = UIImage(named: "\(i)단계(숫자없음흑백)")
            }
        }
    }
}
