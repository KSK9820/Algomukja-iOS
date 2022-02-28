//
//  ItemInfoViewController.swift
//  Algomukja
//
//  Created by 김수경 on 2021/12/02.
//

import UIKit



class ItemInfoViewController: UIViewController {
    
    
    @IBOutlet weak var modalview: UIView!
    
    @IBOutlet weak var iv_product: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_level: UILabel!
    @IBOutlet weak var lbl_view: UILabel!
    @IBOutlet var iv_level: [UIImageView]!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var lbl_info: UILabel!
    
    var tap: UITapGestureRecognizer!
    var product: Payload!
    
   
    
    var message = ["","식물성 음식 이외에는 아무것도 먹지않는 완전한 채식주의 비건입니다.", "치즈, 우유, 요구르트와 같은 유제품을 소비하는 락토 베지테리언입니다.","달걀제품을 소비하는 오보 베지테리언입니다.", "유제품과 달걀제품을 소비하는 락토 오보 베지테리언입니다.", "육류 섭취를 생선이나 해산물로 제한하여 섭취하는 페스코 베지테리언입니다.", "육류 소비를 가금류와 닭만으로 제한하는 폴로 베지테리언입니다.","채식을 하지만 때때로 육식을 하는 플렉시테리언입니다.",]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        UISetting()
        collectionviewSetting()
        contextSetting()
    }
    
    
    func UISetting(){
//        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
//        self.view.isOpaque = true
//        modalview.setViewShadow(backView: modalview, colorName: "900", width: -2, height: 6)
        let url = URL(string: Config.api + product.image)
        iv_product.load(url: url!)
        
    }
    
    func contextSetting(){
        lbl_view.text = String(product.view)
        //"\(product.view)회 조회"
        lbl_name.text = product.name
        lbl_info.setHeight(22)
        if product.finalLevel == 3 && product.level[2] == 1{
            lbl_level.text = message[4]
        }else if product.finalLevel == 3 && product.level[2] == 0{
            lbl_level.text = message[3]
        }else{
            lbl_level.text = message[product.finalLevel]
        }
        setImage()
        scrollview.heightAnchor.constraint(equalToConstant: modalview.frame.height - lbl_name.frame.height - lbl_level.frame.height - 50 - UIScreen.main.bounds.height * 0.3
        ).isActive = true
        lbl_info.setHeight(24)
        lbl_info.text = "원재료명을 선택해보세요!"
       
    }
    
    func setImage(){
//        for i in 1..<7{
//            iv_level[i - 1].image = UIImage(named: "\(i)단계")
//            if product.level[i] == 0 {
//                iv_level[i - 1].image = UIImage(named: "\(i)단계"))
//            }
//        }
       
        for i in 0..<3{
            if product.level[i] == 0 {
                iv_level[i].image = UIImage(named: "\(i + 1)단계(흑백)")
            }
        }
        for i in 4..<7{
            if product.level[i] == 0 {
                iv_level[i - 1].image = UIImage(named: "\(i)단계(흑백)")
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
    
    
    @IBAction func cancecl(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension ItemInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.materials.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let material = product.materials[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MaterialCollectionViewCell.identifier, for: indexPath) as! MaterialCollectionViewCell
        cell.configure(with: material, indexpath: indexPath.row)
        
        if collectionview.contentSize.height <= UIScreen.main.bounds.height * 0.5{
            collectionview.heightAnchor.constraint(equalToConstant: collectionview.contentSize.height).isActive = true

        }else {
            collectionview.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.3).isActive = true
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // dataArary is the managing array for your UICollectionView.
        let item = product.materials[indexPath.row].name
        let itemSize = item.size(withAttributes: [
               NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 27)
           ])
        return itemSize
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var text = "[\(product.materials[indexPath.row].name)]\n\(product.materials[indexPath.row].description)"
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "[\(product.materials[indexPath.row].name)]")
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "level\(product.materials[indexPath.row].level)"), range: range)
        lbl_info.attributedText = attributedString

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MaterialCollectionViewCell.identifier, for: indexPath) as! MaterialCollectionViewCell
        

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

