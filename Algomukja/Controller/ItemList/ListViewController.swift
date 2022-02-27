//
//  ListViewController.swift
//  Algomukja
//
//  Created by 김수경 on 2021/12/01.
//

import UIKit
import Moya

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
}


let screenWidth = UIScreen.main.bounds.width

class ListViewController: UIViewController {

    @IBOutlet var vegan_level: [UIImageView]!
    
    @IBOutlet weak var collectionview: UICollectionView!
    var filterType: ChatAlarmFilterType = .level0
    
    
    let provider = MoyaProvider<ProductService>()
    var request = ProductRequest(type: 1, start: 0, limit: 10)
    var payload = [Payload]()
    var addPayload = [[Payload]](repeating: [], count: 9)
    var lastId = [Int](repeating: 0, count: 9)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UISetting()
        addViewTapGesture()
        getProduct(data: self.request)
        collectionviewSetting()
    }
    
    func UISetting(){
        for i in 0..<6{
            vegan_level[i].isUserInteractionEnabled = true
        }
    }
    

    
    func collectionviewSetting(){
            collectionview.delegate = self
            collectionview.dataSource = self
            collectionview.prefetchDataSource = self
            collectionview.register(ItemCollectionViewCell.nib(), forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
            let flowLayout = UICollectionViewFlowLayout()
            collectionview.collectionViewLayout = flowLayout
        }
    
    func greySetting(except: Int){
        for i in 0..<6{
            if i == except {
                vegan_level[i].image = UIImage(named: String("\(i + 1)단계"))
                vegan_level[i].setViewShadow(backView: vegan_level[i], colorName: "200", width: -1, height: 1)
            }else{
                vegan_level[i].image = UIImage(named: String("\(i + 1)단계(흑백)"))
                vegan_level[i].setViewShadow(backView: vegan_level[i], colorName: "000", width: 0, height: 0)
            }
            
        }
    }
    
    func updateFilterType() {
            switch filterType {
            case .level0:
                greySetting(except: 0)
                setSelectedItem(selected: 1)
            case .level1:
                greySetting(except: 1)
                setSelectedItem(selected: 2)
            case .level2:
                greySetting(except: 2)
                setSelectedItem(selected: 4)
            case .level3:
                greySetting(except: 3)
                setSelectedItem(selected: 5)
            case .level4:
                greySetting(except: 4)
                setSelectedItem(selected: 6)
            case .level5:
                greySetting(except: 5)
                setSelectedItem(selected: 7)
            }
        }

    
    func addViewTapGesture(){
        let tap_0: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_3: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_4: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        let tap_5: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
       
         

        vegan_level[0].addGestureRecognizer(tap_0)
        vegan_level[1].addGestureRecognizer(tap_1)
        vegan_level[2].addGestureRecognizer(tap_2)
        vegan_level[3].addGestureRecognizer(tap_3)
        vegan_level[4].addGestureRecognizer(tap_4)
        vegan_level[5].addGestureRecognizer(tap_5)
        
    }
    
    @objc func buttonTapped(_ sender: UITapGestureRecognizer) {
        if sender.view == vegan_level[0] {
            filterType = .level0
            //각 단계 api get
            request.type = 1
        }
        else if sender.view == vegan_level[1] {
            request.type = 2
            filterType = .level1
        }
        else if sender.view == vegan_level[2] {
            request.type = 4
            filterType = .level2
        }
        else if sender.view == vegan_level[3] {
            request.type = 5
            filterType = .level3
        }
        else if sender.view == vegan_level[4] {
            request.type = 6
            filterType = .level4
        }
        else if sender.view == vegan_level[5] {
            request.type = 7
            filterType = .level5
        }
        
        if addPayload[request.type].count == 0 {
            request.start = 0
            getProduct(data: self.request)
            
        }
        updateFilterType()
    }
    
    
    func setSelectedItem(selected: Int){
        //selectedItem.removeAll()
        for i in 0..<payload.count {
            if payload[i].finalLevel == selected && addPayload[request.type].count == 0{
                addPayload[request.type] += payload
            }
            if i == payload.count - 1 {
                lastId[request.type] = payload[i].id
                print(lastId[request.type])
            }
        }
        payload.removeAll()
        collectionview.reloadData()
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching{
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addPayload[request.type].count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let Info = addPayload[request.type][indexPath.row]
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
        VC.product = addPayload[request.type][indexPath.row]
        print("view:::\(addPayload[request.type][indexPath.row].view)")
        //VC.info = selectedItem[indexPath.row]
        self.present(VC, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            
            if indexPath.row >= addPayload[request.type].count - 2 {
                request.start = lastId[request.type] + 1
                getProduct(data: self.request)
                self.addPayload[request.type] += payload
                setSelectedItem(selected: request.type)

          break
            }
        }
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth - 40, height: 180)
    }

    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
       
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}



extension ListViewController{
    func getProduct(data: ProductRequest){
        provider.request(.getProduct(product: request)){ [weak self] result in
                guard let self = self else {return}
                
                switch result {
                case .success(let response):
                    do{
//                        print("***result: \(try response.mapJSON())")
                        let datas = try JSONDecoder().decode(ProductResponse.self, from: response.data)
                        self.payload = datas.payload
                        print(self.payload)
                        DispatchQueue.main.async{ [self] in
                            if self.addPayload[self.request.type].count == 0 {
                                self.updateFilterType()
                            }else{
                                self.collectionview.reloadData()
                            }
                            
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
}
