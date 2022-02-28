//
//  RankViewController.swift
//  Algomukja
//
//  Created by 김수경 on 2022/01/05.
//

import UIKit
import UPCarouselFlowLayout
import Moya

struct Card {
    let photo, name: String
    let finallevel: Int
    let level: [Int]
}


class RankViewController: UIViewController, UIGestureRecognizerDelegate {
   

    @IBOutlet weak var heightview: UIView!
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
    var card: [ITEM] = [ITEM(photo: "https://contents.lotteon.com/itemimage/_v010018/LF/15/38/53/3_/0/LF1538533_0_1.jpg", name: "고기대신 비건 제육볶음 (냉동)", finalLevel: 0, level: [1,0,0,0,0,0], accurate: true), ITEM(photo: "https://image.homeplus.kr/td/967ef98d-08fd-4ece-a1b5-dd6dd745b4b8", name: "고기대신 맛있는녀석들 비건육포 오리지널", finalLevel: 0, level: [1,0,0,0,0,0], accurate: true), ITEM(photo: "https://image.homeplus.kr/td/2e29ccec-0dc8-438b-acc6-e80e67e15506", name: "풀무원) 국물 떡볶이", finalLevel: 0, level: [1,0,0,0,0,0], accurate: false), ITEM(photo: "https://image.homeplus.kr/td/ef39ed5d-7bc7-4ab2-96d3-908e1601215d", name: "씨제이 삼호 맑은 어묵", finalLevel: 3, level: [1,0,0,1,0,0], accurate: false)]
    
    var item: [ITEM] = []
    var infoItem: ITEM?
    
    let provider = MoyaProvider<SearchService>()
    var request = SearchRequest(keyword: "", start: 0, limit: 100)
    var searchResult: [Payload] = []
    var selectedResult: Payload!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UISetting()
        CollectionViewSetting()
        updateFilterType()
        addViewTapGesture()
        invisibleResult()
        hideKeyboard()
        
//        heightview.translatesAutoresizingMaskIntoConstraints = true

    }
    
    override func viewDidLayoutSubviews() {
        scrollview.contentSize.height = 1000 + self.searchCollectionView.contentSize.height
    }
    func UISetting(){
        topview.layer.cornerRadius = 40
        topview.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        searchView.makeBorder(colorName: "green3")
        searchView.makeRoundView(radius: 10)
        
        tf_search.borderStyle = .none
        tf_search.layer.borderColor = UIColor.clear.cgColor
        
        for i in 0..<6 {
            iv_level[i].isUserInteractionEnabled = true
        }
    }
    
    func CollectionViewSetting(){
        
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
        
        
        
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(ItemCollectionViewCell.nib(), forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: screenWidth - 40, height: 180)
        
        searchCollectionView.collectionViewLayout = flowLayout
        searchCollectionView.isUserInteractionEnabled = true
        
        
    }
    
    
    
    
    func greySetting(except: Int){
        for i in 0..<6{
            if i == except {
                iv_level[i].image = UIImage(named: String("\(i + 1)단계"))
                iv_level[i].setViewShadow(backView: iv_level[i], colorName: "300", width: -1, height: 1)
            }else{
                iv_level[i].image = UIImage(named: String("\(i + 1)단계(흑백)"))
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
//           searchCollectionView.visibility = .gone
       }
       
       func visibleResult(){
           iv_result.visibility = .visible
           
          
           lbl_result.visibility = .visible
           if searchResult.count != 0 {
               searchCollectionView.contentSize.height = CGFloat((searchResult.count) * 190 )
               searchCollectionViewHeight.constant = searchCollectionView.contentSize.height
               
               scrollview.contentSize.height = 1000 + self.searchCollectionView.contentSize.height
               
               
               heightview.frame.size.height = 1000 + self.searchCollectionView.contentSize.height
//               heightview.heightAnchor.constraint(equalToConstant: 4000)
               heightview.frame.size.width = self.view.bounds.width
               
               lbl_result.text = "'\(tf_search.text!)' 제품 검색 결과입니다."
           }else{
               lbl_result.numberOfLines = 2
               lbl_result.text = "'\(tf_search.text!)' 제품 검색 결과가 없습니다. \n 알고 싶은 다른 제품은 없으신가요?"
           }
           self.searchCollectionView.reloadData()
       }

}

extension RankViewController{
    func getSearch(data: SearchRequest){
        provider.request(.getSearch(search: request)){ [weak self] result in
                guard let self = self else {return}
                
                switch result {
                case .success(let response):
                    do{
//                        print("***result: \(try response.mapJSON())")
                        let datas = try JSONDecoder().decode(ProductResponse.self, from: response.data)
                        self.searchResult = datas.payload

                        DispatchQueue.main.async{ [self] in
                            self.visibleResult()
                            self.view.endEditing(true)
                            self.scrollview.setContentOffset(CGPoint(x: 0, y: self.lbl_result.frame.origin.y), animated: true)
                            
                        }

                       
                    }catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                    
                case .failure(let error):
                    
                    print("***error: \(error.localizedDescription)")
                }
                
                
            }
        }
    
    
    @IBAction func nameSearch(_ sender: UIButton) {
        hideKeyboard()
        searchResult.removeAll()
        request.keyword = self.tf_search.text!
        getSearch(data: self.request)
    }

    @objc func tap(_ sender: UITapGestureRecognizer) {

        
        let p = sender.location(in: searchCollectionView)
        if let indexPath = searchCollectionView?.indexPathForItem(at: p){
            selectedResult = searchResult[indexPath.row]
        }
        
      
        
    
        let storyboard = UIStoryboard(name: "ItemList", bundle: nil)
        guard let VC = storyboard.instantiateViewController(identifier: "ItemInfoViewController") as? ItemInfoViewController else {
            print("Controller not found")
            return
        }
        VC.modalPresentationStyle = .overFullScreen
        VC.product = selectedResult
        self.present(VC, animated: true, completion: { [self] in
            searchCollectionView.isUserInteractionEnabled = true
        })
    }
    
    

    
}

extension RankViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CardCollectionView{
            return self.card.count
        }else if collectionView == searchCollectionView{
            return self.searchResult.count
        }
        
        return 0
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == CardCollectionView{
            let data = card[indexPath.row]
            let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as! CardCollectionViewCell
            
            //infoItem에 값 넣기
            Cell.configure(with: data, indexpath: indexPath.row)
            infoItem = card[indexPath.row]
            //Cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
            
           return Cell
        }else if collectionView == searchCollectionView{
            let data = searchResult[indexPath.row]
            let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
//            infoItem = searchResult[indexPath.row]
            Cell.configure(with: data, indexpath: indexPath.row)
            Cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
          
            return Cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if collectionView == searchCollectionView{
            let storyboard = UIStoryboard(name: "ItemList", bundle: nil)
            guard let VC = storyboard.instantiateViewController(identifier: "ItemInfoViewController") as? ItemInfoViewController else {
                print("Controller not found")
                return
            }
            VC.modalPresentationStyle = .overFullScreen
            VC.product = searchResult[indexPath.row]
            self.present(VC, animated: true, completion: nil)
            //selectedResult = searchResult[indexPath.row]
        }
    }
    

    

}
