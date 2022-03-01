//
//  SearchResultViewController.swift
//  Algomukja
//
//  Created by 김수경 on 2022/02/17.
//

import UIKit

protocol CloseDelegate{
    func close(isCamera: Bool)
}




class SearchResultViewController: UIViewController{
    
    var delegate: CloseDelegate?

    
    @IBOutlet weak var modalview: UIView!
    @IBOutlet weak var lbl_level: UILabel!
    @IBOutlet var iv_level: [UIImageView]!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var lbl_info: UILabel!
    
    var tap: UITapGestureRecognizer!
    
    var info: ITEM?
    
    var response = [materialPayload]()
    var temp: Materials!
    var materialName: [String] = []
    var finalLevel: Int = 0
    
//    var isCamera: Bool!
   
    
    var message = ["식물성 음식 이외에는 아무것도 먹지않는 완전한 채식주의 비건입니다.", "치즈, 우유, 요구르트와 같은 유제품을 소비하는 락토 베지테리언입니다.","달걀제품을 소비하는 오보 베지테리언입니다.", "유제품과 달걀제품을 소비하는 락토 오보 베지테리언입니다.", "육류 섭취를 생선이나 해산물로 제한하여 섭취하는 페스코 베지테리언입니다.", "육류 소비를 가금류와 닭만으로 제한하는 폴로 베지테리언입니다.","채식을 하지만 때때로 육식을 하는 플렉시테리언입니다.","정확한 분류가 어렵습니다. 제조사에 문의해주세요."]
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        backgroundSetting()
        collectionviewSetting()
        contextSetting()
        self.collectionview.reloadData()
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
    
    
    @IBAction func openGallery(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate?.close(isCamera: false)
        })
        
    }
    
    @IBAction func openCamera(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate?.close(isCamera: true)
        })
    }
    
    
    func backgroundSetting(){
        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.view.isOpaque = true
        modalview.setViewShadow(backView: modalview, colorName: "900", width: -2, height: 6)
        
    }
    
    func contextSetting(){
        lbl_info.setHeight(22)
        //***************여기해야댐
//        if info?.finalLevel == 3 && info?.level[2] == 1{
//            lbl_level.text = message[6]
//        }else {
//            lbl_level.text = message[info!.finalLevel]
//        }
//        setImage()
        
        
        scrollview.heightAnchor.constraint(equalToConstant: modalview.frame.height -  lbl_level.frame.height - 50 - UIScreen.main.bounds.height * 0.3
        ).isActive = true
        lbl_info.setHeight(24)
        lbl_info.text = "원재료명을 선택해보세요!"
       
    }
    
    func setImage(){
        for i in 0..<6{
            iv_level[i].image = UIImage(named: String(i))
            if info?.level[i] == 0 {
                iv_level[i].setImageColor(color: UIColor(named: "400")!)
            }
        }
    }
    
    func collectionviewSetting(){
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(MaterialCollectionViewCell.nib(), forCellWithReuseIdentifier: MaterialCollectionViewCell.identifier)
        
        collectionview.collectionViewLayout = flowLayout
       
        
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.response.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let info = response[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MaterialCollectionViewCell.identifier, for: indexPath) as! MaterialCollectionViewCell
        
        if !info.`internal`.isEmpty {
            temp = Materials(id: info.`internal`[0].id, name: info.`internal`[0].name, level: info.`internal`[0].level, description: info.`internal`[0].description)
        }else if !info.external.isEmpty {
            temp = Materials(id: 0, name: info.external[0].name, level: 7, description: info.external[0].description)
        }else{
            temp = Materials(id: 0, name: materialName[indexPath.row], level: 7, description: "")
        }
        
        if finalLevel < temp.level {
            finalLevel = temp.level
            lbl_level.text = message[finalLevel]
        }
        
        cell.configure(with: temp, indexpath: indexPath.row)
        
        //cell.configure(with: info, indexpath: indexPath.row)
        
        if collectionview.contentSize.height <= UIScreen.main.bounds.height * 0.5{
            collectionview.heightAnchor.constraint(equalToConstant: collectionview.contentSize.height).isActive = true

        }else {
            collectionview.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.3).isActive = true
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // dataArary is the managing array for your UICollectionView.
        var item: String = ""
        if !self.response[indexPath.row].`internal`.isEmpty {
            item = response[indexPath.row].`internal`[0].name
        }else if !self.response[indexPath.row].external.isEmpty{
            item = response[indexPath.row].external[0].name
        }else{
            item = materialName[indexPath.row]
        }
       
        let itemSize = item.size(withAttributes: [
               NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 27)
           ])
        return itemSize
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !self.response[indexPath.row].`internal`.isEmpty {
            lbl_info.text = self.response[indexPath.row].`internal`[0].description
        }else if !self.response[indexPath.row].external.isEmpty{
            lbl_info.text = self.response[indexPath.row].external[0].description
        }else{
            lbl_info.text = "검색 결과가 없습니다. 제조사에 문의해주세요."
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MaterialCollectionViewCell.identifier, for: indexPath) as! MaterialCollectionViewCell
        cell.lbl_meterial.setViewShadow(backView: cell.lbl_meterial, colorName: "400", width: -2, height: 2)
    }
    

}


extension SearchResultViewController: UIGestureRecognizerDelegate {
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        tap = UITapGestureRecognizer(target: self, action: #selector(onTap(sender:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        tap.cancelsTouchesInView = false
        tap.delegate = self
        self.view.window?.addGestureRecognizer(tap)
    }
    
    internal func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    internal func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let location = touch.location(in: self.modalview)
        
        if self.view.point(inside: location, with: nil) {
            return false
        }
        else {
            return true
        }
    }
    
    @objc private func onTap(sender: UITapGestureRecognizer) {
        
        self.view.window?.removeGestureRecognizer(sender)
        self.dismiss(animated: true, completion: nil)
    }
    
}

