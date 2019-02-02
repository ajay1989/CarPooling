//
//  Registration6VC.swift
//  CarPooling
//
//  Created by archit rai saxena on 12/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
class Registration6VC: BaseViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //fb Les conducteurs sont plus rassurés lorsqu'ils voient les visages de leurs futurs passagers 🕵️‍♂️
    
   // Multiplie les chances de faire valider ta demande en choisissant une photo sur laquelle on peut te reconnaître facilement.
    
   // Si celle-ci fait l'affaire,appuie sur continuer😎 Sinon, nous te recommandons de la modifier.
    
    //.....
    // Les conducteurs sont plus rassurés lorsqu'ils voient les visages de leurs futurs passagers 🕵️‍♂️
    
    // Multiplie les chances de faire valider ta demande en choisissant une photo sur laquelle on peut te reconnaître facilement 😎.
    
    

    @IBOutlet weak var lbl_detailText: UILabel!
    
    
    @IBOutlet weak var btn_continue: UIButton!
    @IBOutlet weak var img_profile: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    
    
     var pickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.lbl_name.text = "\(AppHelper.getStringForKey(ServiceKeys.keyFirstName))"
        if !AppHelper.getStringForKey(ServiceKeys.keyProfileImage).isEqualToString(find: "") {
            let url =  URL(string:AppHelper.getStringForKey(ServiceKeys.keyProfileImage))
            
            self.img_profile.af_setImage(withURL: url!)
            lbl_detailText.text = "Les conducteurs sont plus rassurés lorsqu'ils voient les visages de leurs futurs passagers 🕵️‍♂️ \n \n Multiplie les chances de faire valider ta demande en choisissant une photo sur laquelle on peut te reconnaître facilement. \n \n Si celle-ci fait l'affaire,appuie sur continuer😎 Sinon, nous te recommandons de la modifier."
        }
        else {
            lbl_detailText.text = "Les conducteurs sont plus rassurés lorsqu'ils voient les visages de leurs futurs passagers 🕵️‍♂️ \n \n Multiplie les chances de faire valider ta demande en choisissant une photo sur laquelle on peut te reconnaître facilement 😎."
          self.continueDisable()
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func btn_profilePic_tap(_ sender: Any) {
        let alertViewController = UIAlertController(title: "", message: NSLocalizedString("Choose your option", comment: ""), preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: { (alert) in
            self.openCamera()
        })
        let gallery = UIAlertAction(title: NSLocalizedString("Gallery", comment: ""), style: .default) { (alert) in
            self.openGallary()
        }
        let cancel = UIAlertAction(title:  NSLocalizedString("Cancel", comment: ""), style: .cancel) { (alert) in
            
        }
        alertViewController.addAction(camera)
        alertViewController.addAction(gallery)
        alertViewController.addAction(cancel)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            pickerController.delegate = self
            self.pickerController.sourceType = UIImagePickerController.SourceType.camera
            pickerController.allowsEditing = true
            self .present(self.pickerController, animated: true, completion: nil)
        }
        else {
            let alertWarning = UIAlertView(title:NSLocalizedString("Warning", comment: ""), message: NSLocalizedString("You don't have camera", comment: ""), delegate:nil, cancelButtonTitle:NSLocalizedString("OK", comment: ""), otherButtonTitles:"")
            alertWarning.show()
        }
    }
    func openGallary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
            pickerController.allowsEditing = true
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage]! as! UIImage
       self.img_profile.image = image
        self.continueEnable()
        
        dismiss(animated:true, completion: nil)
    }
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
    }
    
     @IBAction func btn_continue_tap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: Registration7VC = storyboard.instantiateViewController(withIdentifier: "Registration7VC") as! Registration7VC
        vc.image = self.img_profile.image!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func continueEnable() {
        btn_continue.isEnabled = true
        btn_continue.setTitle("Continuer👉", for: .normal)
        btn_continue.setTitleColor(UIColor.black, for: .normal)
    }
    
    func continueDisable() {
        btn_continue.isEnabled = false
        btn_continue.setTitle("Continuer👉🏼", for: .normal)
        btn_continue.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
}
