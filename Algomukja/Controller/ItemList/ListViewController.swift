//
//  ListViewController.swift
//  Algomukja
//
//  Created by 김수경 on 2021/12/01.
//

import UIKit

struct ITEM {
    let photo, name: String
    let finalLevel: Int
    let level: [Int]
    let accurate: Bool?
}

enum ChatAlarmFilterType {
    case level0
    case level1
    case level2
    case level3
    case level4
    case level5
    case level6
}


let screenWidth = UIScreen.main.bounds.width

class ListViewController: UIViewController {

    @IBOutlet var vegan_level: [UIImageView]!
    @IBOutlet weak var collectionview: UICollectionView!
    var filterType: ChatAlarmFilterType = .level0
    
    var item: [ITEM] = [ITEM(photo: "https://contents.lotteon.com/itemimage/_v010018/LF/15/38/53/3_/0/LF1538533_0_1.jpg", name: "고기대신 비건 제육볶음 (냉동)", finalLevel: 1, level: [0,1,0,0,0,0,0], accurate: true), ITEM(photo: "https://image.homeplus.kr/td/967ef98d-08fd-4ece-a1b5-dd6dd745b4b8", name: "고기대신 맛있는녀석들 비건육포 오리지널", finalLevel: 1, level: [0,1,0,0,0,0,0], accurate: false), ITEM(photo: "https://image.homeplus.kr/td/ef39ed5d-7bc7-4ab2-96d3-908e1601215d", name: "씨제이 삼호 맑은 어묵", finalLevel: 4, level: [0,1,0,0,1,0,0], accurate: false), ITEM(photo: "https://image.homeplus.kr/td/29983ea0-51ff-4a94-813e-8922cd372d0b", name: "홈플러스시그니처 매콤한 순대 볶음", finalLevel: 6, level: [0,1,1,0,0,0,1], accurate: false), ITEM(photo: "https://image.homeplus.kr/td/2e29ccec-0dc8-438b-acc6-e80e67e15506", name: "풀무원 국물 떡볶이", finalLevel: 1, level: [1,1,0,0,0,0,0], accurate: false), ITEM(photo: "https://image.homeplus.kr/td/e334c618-804c-4905-b262-4f3f71ab9ddc", name: "농심 올리브 짜파게티", finalLevel: 6, level: [0,1,1,1,1,0,1], accurate: false), ITEM(photo: "https://image.homeplus.kr/td/e2f6ca0b-9cf3-497a-a922-ac9ab03de5d5", name: "착한톡톡 사과비트즙", finalLevel: 0, level: [1,0,0,0,0,0,0], accurate: false)]
    
    var selectedItem: [ITEM] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UISetting()
        collectionviewSetting()
        updateFilterType()
        addViewTapGesture()
        
    }
    
    func UISetting(){
        for i in 0..<7{
            vegan_level[i].isUserInteractionEnabled = true
        }
    }
    
    func greySetting(except: Int){
        for i in 0..<7{
            if i == except {
//                continue
                vegan_level[i].image = UIImage(named: String(except))
            }else{
                vegan_level[i].setImageColor(color: UIColor(named: "400")!)
            }
            
        }
    }
    
    func collectionviewSetting(){
            collectionview.delegate = self
            collectionview.dataSource = self
            collectionview.register(ItemCollectionViewCell.nib(), forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
            let flowLayout = UICollectionViewFlowLayout()
            collectionview.collectionViewLayout = flowLayout
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
            case .level6:
                greySetting(except: 6)
                setSelectedItem(selected: 6)
                
            }
        }

    
    func addViewTapGesture(){
        let tap_0: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_3: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_4: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_5: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_6: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
         

        vegan_level[0].addGestureRecognizer(tap_0)
        vegan_level[1].addGestureRecognizer(tap_1)
        vegan_level[2].addGestureRecognizer(tap_2)
        vegan_level[3].addGestureRecognizer(tap_3)
        vegan_level[4].addGestureRecognizer(tap_4)
        vegan_level[5].addGestureRecognizer(tap_5)
        vegan_level[6].addGestureRecognizer(tap_6)
    }
    
    @objc func buttonTapped(_ sender: UITapGestureRecognizer) {
        if sender.view == vegan_level[0] {
            filterType = .level0
            //각 단계 api get
        }
        else if sender.view == vegan_level[1] {
            filterType = .level1
        }
        else if sender.view == vegan_level[2] {
            filterType = .level2
        }
        else if sender.view == vegan_level[3] {
            filterType = .level3
        }
        else if sender.view == vegan_level[4] {
            filterType = .level4
        }
        else if sender.view == vegan_level[5] {
            filterType = .level5
        }
        else if sender.view == vegan_level[6] {
            filterType = .level6
        }
        updateFilterType()
        
    }
    
    
    func setSelectedItem(selected: Int){
        selectedItem.removeAll()
        for i in 0..<item.count{
            if item[i].finalLevel == selected {
                selectedItem.append(item[i])
            }
            collectionview.reloadData()
        }
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedItem.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let Info = selectedItem[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
        cell.configure(with: Info, indexpath: indexPath.row)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ItemList", bundle: nil)
        guard let VC = storyboard.instantiateViewController(identifier: "ItemInfoViewController") as? ItemInfoViewController else {
            print("Controller not found")
            return
        }
        VC.modalPresentationStyle = .overFullScreen
        VC.info = selectedItem[indexPath.row]
        self.present(VC, animated: true, completion: nil)
    }
    
    
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth - 40, height: 180)
    }

    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
       
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
