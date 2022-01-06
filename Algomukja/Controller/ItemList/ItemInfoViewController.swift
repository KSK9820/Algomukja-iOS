//
//  ItemInfoViewController.swift
//  Algomukja
//
//  Created by 김수경 on 2021/12/02.
//

import UIKit

struct material{
    let name: String
    let level: Int
    let info: String
}

class ItemInfoViewController: UIViewController {
    
    @IBOutlet weak var modalview: UIView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_level: UILabel!
    @IBOutlet var iv_level: [UIImageView]!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var lbl_info: UILabel!
    
    var tap: UITapGestureRecognizer!
    
    var info: ITEM?
   
    
    var message = ["식물성 음식 이외에는 아무것도 먹지않는 완전한 채식주의 비건입니다.", "치즈, 우유, 요구르트와 같은 유제품을 소비하는 락토 베지테리언입니다.","달걀제품을 소비하는 오보 베지테리언입니다.", "육류 섭취를 생선이나 해산물로 제한하여 섭취하는 페스코 베지테리언입니다.", "육류 소비를 가금류와 닭만으로 제한하는 폴로 베지테리언입니다.","채식을 하지만 때때로 육식을 하는 플렉시테리언입니다.","유제품과 달걀제품을 소비하는 락토 오보 베지테리언입니다."]
    
    var material_info: [material] = [material(name: "소맥분", level: 0, info: "밀의 배유부분을 가루로 만든 것"), material(name: "감자전분", level: 0, info: "녹말가루. 식물의 뿌리나 덩이줄기, 줄기, 열매, 씨의 전분을 가루로 만든 것"), material(name: "팜유", level: 0, info: "팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름팜 유화학용어사전 팜 나무(기름 야자) 열매의 과육 기름으로 방(함유분 16~20%)마다 쪄서 압축 채유되는 식물성 기름"), material(name: "계란", level: 2, info: "닭이 낳은 알"), material(name: "우유", level: 1, info: "암소의 젖."), material(name: "대두", level: 0, info: "‘밭의 고기’라고 불릴 정도로 양질의 식물성 단백질과 지방이 풍부한 대두는 우리가 매일 접하는 간장, 된장의 원료로 이용되고 두부, 콩나물과 같은 필수 식품의 원천이다."), material(name: "돼지고기", level: 5, info: "멧돼지과의 포유동물로 정육을 식용으로 소비할 목적으로 사육한다"), material(name: "새우", level: 3, info:"바다 또는 민물에 사는 소형 십각류를 통칭하는 용어이다."), material(name: "쇠고기", level: 5, info: "도축 소의 고기")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        backgroundSetting()
        collectionviewSetting()
        contextSetting()
    }
    
    
    func backgroundSetting(){
        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.view.isOpaque = true
        modalview.setViewShadow(backView: modalview, colorName: "900", width: -2, height: 6)
        
    }
    
    func contextSetting(){
        lbl_name.text = info?.name
        lbl_info.setHeight(22)
        if info?.finalLevel == 3 && info?.level[2] == 1{
            lbl_level.text = message[6]
        }else {
            lbl_level.text = message[info!.finalLevel]
        }
        setImage()
        scrollview.heightAnchor.constraint(equalToConstant: modalview.frame.height - lbl_name.frame.height - lbl_level.frame.height - 50 - UIScreen.main.bounds.height * 0.3
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

extension ItemInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return material_info.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let info = material_info[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MaterialCollectionViewCell.identifier, for: indexPath) as! MaterialCollectionViewCell
        cell.configure(with: info, indexpath: indexPath.row)
        
        if collectionview.contentSize.height <= UIScreen.main.bounds.height * 0.5{
            collectionview.heightAnchor.constraint(equalToConstant: collectionview.contentSize.height).isActive = true

        }else {
            collectionview.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.3).isActive = true
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // dataArary is the managing array for your UICollectionView.
        let item = material_info[indexPath.row].name
        let itemSize = item.size(withAttributes: [
               NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 27)
           ])
        return itemSize
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lbl_info
            .text = material_info[indexPath.row].info
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MaterialCollectionViewCell.identifier, for: indexPath) as! MaterialCollectionViewCell
        cell.lbl_meterial.setViewShadow(backView: cell.lbl_meterial, colorName: "400", width: -2, height: 2)
    }
    

}


extension ItemInfoViewController: UIGestureRecognizerDelegate {
    
    
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

