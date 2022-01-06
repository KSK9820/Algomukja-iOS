//
//  MaterialCollectionViewCell.swift
//  Algomukja
//
//  Created by 김수경 on 2021/12/03.
//

import UIKit

protocol didselectEvent{
    func didselect(indexPath: Int)
}

class MaterialCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var materialview: UIView!
    @IBOutlet weak var lbl_meterial: UILabel!
    
    static var identifier = "MaterialCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UISetting()
    }
    
    func UISetting(){
        //setViewShadow(backView: materialview, colorName: "400", width: -1, height: 1)
        lbl_meterial.sizeToFit()
    }

    
    
    static func nib() -> UINib {
              return UINib(nibName: "MaterialCollectionViewCell", bundle: nil)
       }
    
    
    
    public func configure(with material: material, indexpath: Int){
        lbl_meterial.text = material.name
        lbl_meterial.backgroundColor = UIColor(named: "level\(material.level + 1)")
        lbl_meterial.makeRoundView(radius: 10)
        
    }
}
