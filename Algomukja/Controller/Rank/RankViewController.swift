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
   

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tf_search: UITextField!
    @IBOutlet var iv_level: [UIImageView]!
    @IBOutlet weak var CardCollectionView: UICollectionView!
    @IBOutlet weak var iv_result: UIView!
    @IBOutlet weak var lbl_result: UILabel!
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var searchCollectionViewHeight: NSLayoutConstraint!
    
    var filterType: ChatAlarmFilterType = .level0
    var selectedItem: [Card] = []
    var card: [Card] = [Card(photo: "https://contents.lotteon.com/itemimage/_v010018/LF/15/38/53/3_/0/LF1538533_0_1.jpg", name: "고기대신 비건 제육볶음 (냉동)", manufacture: "vioMix", finallevel: 0, level: [1,0,0,0,0,0]), Card(photo: "https://image.homeplus.kr/td/967ef98d-08fd-4ece-a1b5-dd6dd745b4b8", name: "고기대신 맛있는녀석들 비건육포 오리지널", manufacture: "vioMix", finallevel: 0, level: [1,0,0,0,0,0]), Card(photo: "https://image.homeplus.kr/td/2e29ccec-0dc8-438b-acc6-e80e67e15506", name: "풀무원) 국물 떡볶이", manufacture: "풀무원", finallevel: 0, level: [1,0,0,0,0,0]), Card(photo: "https://image.homeplus.kr/td/ef39ed5d-7bc7-4ab2-96d3-908e1601215d", name: "씨제이 삼호 맑은 어묵", manufacture: "CJ", finallevel: 3, level: [1,0,0,1,0,0])]
    
    var item: [ITEM] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UISetting()
        CollectionViewSetting()
        updateFilterType()
        addViewTapGesture()
        invisibleResult()
        hideKeyboard()
       
    }
    
    override func viewDidLayoutSubviews() {
//        self.changeCollectionHeight()
        scrollview.contentSize.height = 700 + self.searchCollectionView.contentSize.height
       
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
    
    
    
    func greySetting(except: Int){
        for i in 0..<6{
            if i == except {
                iv_level[i].image = UIImage(named: String(except))
                iv_level[i].setViewShadow(backView: iv_level[i], colorName: "200", width: -1, height: 1)
            }else{
                iv_level[i].setImageColor(color: UIColor(named: "400")!)
                iv_level[i].setViewShadow(backView: iv_level[i], colorName: "000", width: 0, height: 0)
            }
            
        }
    }
    
    
    func updateFilterType() {
            switch filterType {
            case .level0:
                greySetting(except: 0)
                setSelectedItem(selected: 0)
            case .level1:
                greySetting(except: 1)
                setSelectedItem(selected: 1)
            case .level2:
                greySetting(except: 2)
                setSelectedItem(selected: 2)
            case .level3:
                greySetting(except: 3)
                setSelectedItem(selected: 3)
            case .level4:
                greySetting(except: 4)
                setSelectedItem(selected: 4)
            case .level5:
                greySetting(except: 5)
                setSelectedItem(selected: 5)
            }
        }

    
    func addViewTapGesture(){
        let tap_0: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_3: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_4: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_5: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
       
         

        iv_level[0].addGestureRecognizer(tap_0)
        iv_level[1].addGestureRecognizer(tap_1)
        iv_level[2].addGestureRecognizer(tap_2)
        iv_level[3].addGestureRecognizer(tap_3)
        iv_level[4].addGestureRecognizer(tap_4)
        iv_level[5].addGestureRecognizer(tap_5)
        
    }
    
    @objc func buttonTapped(_ sender: UITapGestureRecognizer) {
        if sender.view == iv_level[0] {
            filterType = .level0
            //각 단계 api get
        }
        else if sender.view == iv_level[1] {
            filterType = .level1
        }
        else if sender.view == iv_level[2] {
            filterType = .level2
        }
        else if sender.view == iv_level[3] {
            filterType = .level3
        }
        else if sender.view == iv_level[4] {
            filterType = .level4
        }
        else if sender.view == iv_level[5] {
            filterType = .level5
        }
       
        updateFilterType()
        
    }
    
    
    func setSelectedItem(selected: Int){
//        selectedItem.removeAll()
//        for i in 0..<card.count{
//            if card[i].finallevel == selected {
//                selectedItem.append(card[i])
//            }
//            CardCollectionView.reloadData()
//        }
    }
    
    
    func invisibleResult(){
        iv_result.visibility = .gone
        lbl_result.visibility = .gone
        //searchCollectionView.visibility = .invisible
    }
    
    func visibleResult(){
        iv_result.visibility = .visible
        
        lbl_result.text = "'\(tf_search.text!)' 제품 검색 결과입니다."
        lbl_result.visibility = .visible
        searchCollectionView.visibility = .visible
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(ItemCollectionViewCell.nib(), forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: screenWidth - 40, height: 180)
        
        searchCollectionView.collectionViewLayout = flowLayout
        
        
        searchCollectionView.contentSize.height = CGFloat(self.item.count * 190)
        searchCollectionViewHeight.constant = searchCollectionView.contentSize.height

    }
    
    
    
    
}

extension RankViewController{
    @IBAction func nameSearch(_ sender: UIButton) {
        hideKeyboard()
        self.item = [ITEM(photo: "https://contents.lotteon.com/itemimage/_v010018/LF/15/38/53/3_/0/LF1538533_0_1.jpg", name: "고기대신 비건 제육볶음 (냉동)", finalLevel: 0, level: [1,0,0,0,0,0], accurate: true), ITEM(photo: "https://image.homeplus.kr/td/967ef98d-08fd-4ece-a1b5-dd6dd745b4b8", name: "고기대신 맛있는녀석들 비건육포 오리지널", finalLevel: 0, level: [1,0,0,0,0,0], accurate: false), ITEM(photo: "https://image.homeplus.kr/td/ef39ed5d-7bc7-4ab2-96d3-908e1601215d", name: "씨제이 삼호 맑은 어묵", finalLevel: 3, level: [1,0,0,1,0,0], accurate: false), ITEM(photo: "https://image.homeplus.kr/td/29983ea0-51ff-4a94-813e-8922cd372d0b", name: "홈플러스시그니처 매콤한 순대 볶음", finalLevel: 5, level: [1,1,0,0,0,1], accurate: false), ITEM(photo: "https://image.homeplus.kr/td/2e29ccec-0dc8-438b-acc6-e80e67e15506", name: "풀무원 국물 떡볶이", finalLevel: 0, level: [1,0,0,0,0,0], accurate: false), ITEM(photo: "https://image.homeplus.kr/td/e334c618-804c-4905-b262-4f3f71ab9ddc", name: "농심 올리브 짜파게티", finalLevel: 5, level: [1,1,1,1,0,1], accurate: false)]
        self.visibleResult()
        
        self.scrollview.setContentOffset(CGPoint(x: 0, y: lbl_result.frame.origin.y), animated: true)

    }
}

extension RankViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CardCollectionView{
            
            return self.card.count
        }else if collectionView == searchCollectionView{
            return self.item.count
        }
        
        return 0
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == CardCollectionView{
            let data = card[indexPath.row]
            let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as! CardCollectionViewCell
            Cell.configure(with: data, indexpath: indexPath.row)

           return Cell
        }else if collectionView == searchCollectionView{
            let data = item[indexPath.row]
            let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
            Cell.configure(with: data, indexpath: indexPath.row)
            return Cell
            
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ItemList", bundle: nil)
        guard let VC = storyboard.instantiateViewController(identifier: "ItemInfoViewController") as? ItemInfoViewController else {
            print("Controller not found")
            return
        }
        VC.modalPresentationStyle = .overFullScreen
        VC.info = item[indexPath.row]
        self.present(VC, animated: true, completion: nil)
    }
}
