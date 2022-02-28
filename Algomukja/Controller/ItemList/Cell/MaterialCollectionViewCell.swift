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
    var selectedColor: String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UISetting()
    }
    
    override var isSelected: Bool {
        didSet {
            if selectedColor != nil{
                self.lbl_meterial.backgroundColor = isSelected ? UIColor(named: selectedColor) : .none
            }
            
            //self.imageView.alpha = isSelected ? 0.75 : 1.0
        }
    }
    

    
    func UISetting(){
        //setViewShadow(backView: materialview, colorName: "400", width: -1, height: 1)
        lbl_meterial.sizeToFit()
    }

    
    
    static func nib() -> UINib {
              return UINib(nibName: "MaterialCollectionViewCell", bundle: nil)
       }
    
    
    
    public func configure(with material: Materials, indexpath: Int){
        lbl_meterial.text = material.name
        lbl_meterial.makeBorder(colorName: "level\(material.level)")
        selectedColor = "level\(material.level)"
//        lbl_meterial.backgroundColor = UIColor(named: "level\(material.level)")
//        if material.level == 10 || material.level ==  0 {
//            lbl_meterial.backgroundColor = UIColor(named: "level0")
        
//        }
        lbl_meterial.makeRoundView(radius: 8)
        
    }
}
