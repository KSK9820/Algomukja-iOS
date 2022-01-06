//
//  RankViewController.swift
//  Algomukja
//
//  Created by 김수경 on 2022/01/05.
//

import UIKit
import UPCarouselFlowLayout

struct Card {
    let photo, name, manufacture: String
    let finallevel: Int
    let level: [Int]
}


class RankViewController: UIViewController {
   

    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tf_search: UITextField!
    @IBOutlet var iv_level: [UIImageView]!
    @IBOutlet weak var CardCollectionView: UICollectionView!
    
    var card: [Card] = [Card(photo: "https://contents.lotteon.com/itemimage/_v010018/LF/15/38/53/3_/0/LF1538533_0_1.jpg", name: "고기대신 비건 제육볶음 (냉동)", manufacture: "vioMix", finallevel: 0, level: [1,0,0,0,0,0]), Card(photo: "https://image.homeplus.kr/td/967ef98d-08fd-4ece-a1b5-dd6dd745b4b8", name: "고기대신 맛있는녀석들 비건육포 오리지널", manufacture: "vioMix", finallevel: 0, level: [1,0,0,0,0,0]), Card(photo: "https://image.homeplus.kr/td/2e29ccec-0dc8-438b-acc6-e80e67e15506", name: "풀무원 국물 떡볶이", manufacture: "풀무원", finallevel: 0, level: [1,0,0,0,0,0])]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UISetting()
        CollectionViewSetting()

        
    }
    
    func UISetting(){
        topview.layer.cornerRadius = 40
        topview.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        topview.setViewShadow(backView: topview, colorName: "level6", width: -2, height: 2)
        //topview.layer.masksToBounds = true
        
        searchView.setViewShadow(backView: searchView, colorName: "300", width: -3, height: 2)
        searchView.makeRoundView(radius: 30)
        tf_search.borderStyle = .none
        tf_search.layer.borderColor = UIColor.clear.cgColor
        
        for i in 0..<6 {
            iv_level[i].backgroundColor = .white
            iv_level[i].setViewShadow(backView: iv_level[i], colorName: "200", width: -1, height: 1)
            iv_level[i].isUserInteractionEnabled = true
        }
    }
    
    func CollectionViewSetting(){
//        CardCollectionView.backgroundColor = UIColor(named: "100")
        
        CardCollectionView.register(CardCollectionViewCell.nib(), forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        
        CardCollectionView.delegate = self
        CardCollectionView.dataSource = self
        CardCollectionView.contentInset = UIEdgeInsets.init(top: 20, left: 0, bottom: 20, right: 0)
        

        
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: 280, height: 380)
        layout.scrollDirection = .horizontal
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: 30)
        layout.sideItemScale = 0.7
        
        
        CardCollectionView.collectionViewLayout = layout
        
    }
    
    
    
}

extension RankViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CardCollectionView{
            
            return self.card.count
        }
        
        return 0
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = card[indexPath.row]
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as! CardCollectionViewCell
        Cell.configure(with: data, indexpath: indexPath.row)

       return Cell
    }
    
    
    
}



//extension RankViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //let width = collectionView.frame.width
//        //        let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) /// 안쪽 margin 3 + collectionviewlayout - 16
//        //let itemsPerRow: CGFloat = 1
//        //let widthPadding = sectionInsets.left * (itemsPerRow + 1)
//
//        return CGSize(width: 300, height: 420)
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//    }
//}

