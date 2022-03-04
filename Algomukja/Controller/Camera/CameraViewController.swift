//
//  CameraViewController.swift
//  Algomukja
//
//  Created by 김수경 on 2021/12/21.
//

import UIKit
import FloatingPanel
import Moya
import Photos


class CameraViewController: UIViewController, OpenDelegate {
    func open(isCamera: Bool) {
        if isCamera == true {
            CameraSetting()
        }else{
            GallerySetting()
        }
    }

    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
    @IBOutlet weak var imageview: UIImageView!
    
    var fpc: FloatingPanelController!
   
    let provider = MoyaProvider<CameraService>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        checkSimulator()
        UISetting()
        openEditFloating()
    }
    
    

    
   
    
    func UISetting(){
        
        btnGallery.setViewShadow(backView: btnCamera, colorName: "200", width: -2, height: 2)
        btnCamera.setViewShadow(backView: btnCamera, colorName: "200", width: -2, height: 2)
    
       
    }
    
    func checkSimulator(){
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alertController = UIAlertController(title: nil, message: "Device has no camera.", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "Alright", style: .default, handler: { (alert: UIAlertAction!) in
            })

            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            CameraSetting()
        }
        
    }
    
    
    

    
    func CameraSetting(){
        var camera = UIImagePickerController()
        camera.sourceType = .camera
        camera.allowsEditing = true
        camera.cameraDevice = .rear
        camera.cameraCaptureMode = .photo
        camera.delegate = self
        present(camera, animated: true, completion: nil)
    }
    
    func GallerySetting(){
        let gallery = UIImagePickerController()
        gallery.delegate = self
        gallery.sourceType = .photoLibrary
        present(gallery, animated: true, completion: nil)
    }
    
    func openEditFloating(){

        fpc = FloatingPanelController()
        fpc.delegate = self
        let vc = storyboard!.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
//        vc.isCamera = isCamera
        vc.ocrImage = imageview.image
        vc.openDelegate = self
        fpc.set(contentViewController: vc)
        fpc.changePanelStyle()
        fpc.layout = MyFloatingPanelLayout()
        fpc.addPanel(toParent: self)
        fpc.show()
        //fpc.didMove(toParent: self)
    }
    
    func removeEditFloatin(){
        fpc.willMove(toParent: nil)
        fpc.hide(animated: true, completion: { [self] in
            fpc.removeFromParent()
        })
    }

}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, FloatingPanelControllerDelegate {
  
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
                imageview.image = image
            }else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageview.image = image
                
            }

        picker.dismiss(animated: true, completion:{
            self.openEditFloating()
        })
            
            
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
}

class MyFloatingPanelLayout: FloatingPanelLayout{
    
    var position: FloatingPanelPosition {
        return .bottom
    }
    
    var initialState: FloatingPanelState {
        return .half
    }
    
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        
        return [
            //.full: FloatingPanelLayoutAnchor(absoluteInset: 570, edge: .bottom, referenceGuide: .superview),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 400, edge: .bottom, referenceGuide: .superview),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 113, edge: .bottom, referenceGuide: .superview)
        ]
    }
}


extension FloatingPanelController {
    func changePanelStyle() {
        let appearance = SurfaceAppearance()
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor(named: "100")!
        shadow.offset = CGSize(width: 0, height: -4.0)
        shadow.opacity = 0.15
        shadow.radius = 3
        appearance.shadows = [shadow]
        appearance.cornerRadius = 40
        appearance.backgroundColor = UIColor(named: "100")
        appearance.borderColor = UIColor(named: "green1")
        appearance.borderWidth = 3
        
        surfaceView.grabberHandle.isHidden = true
        surfaceView.appearance = appearance
    }
}


extension CameraViewController{
    @IBAction func btnCamera(_ sender: Any) {
        CameraSetting()
    }
    @IBAction func btnGallery(_ sender: Any) {
        GallerySetting()
    }
    
}
