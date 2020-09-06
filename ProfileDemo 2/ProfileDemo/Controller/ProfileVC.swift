//
//  ProfileVC.swift
//  ProfileDemo
//
//  Created by a on 5/13/20.
//  Copyright © 2020 a. All rights reserved.
//

import UIKit


class ProfileVC: UIViewController {

    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var emailLable: UILabel!
    @IBOutlet weak var phoneLable: UILabel!
    @IBOutlet weak var genderLable: UILabel!
    @IBOutlet weak var addressLable: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    
    
   var user : User!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
         myImage.layer.cornerRadius=myImage.frame.size.width/2
        self.navigationItem.title = "Profile Screen"
        DataBaseManager.shared.connectDataBase()
        getData()

//        if let user1 = UserDefaults.standard.object(forKey: "user") as? Data {
//            if let obj = try? decoder.decode(User.self, from: user1) {
//       nameLable.text = obj.name
//        emailLable.text = obj.email
//        phoneLable.text = obj.phoneNum
//        genderLable.text = obj.gender
//        addressLable.text = obj.address
//         myImage.image = obj.image?.getImage()
//
//    }
//        }
//

    }
    
    func getData() {
        guard let emailCashed = UserDefaults.standard.object(forKey:
            constants().lastLoginAccontEmail)
            else {
                print(1)
                return}
print (emailCashed)
        DataBaseManager.shared.GetDataForProfile(email: emailCashed as! String) { (emailAddress, password, phone, image, country, name, gender) in
            
            self.nameLable.text = name
            self.emailLable.text = emailAddress
            self.phoneLable.text = phone
            self.genderLable.text = gender
            self.addressLable.text = country
            self.myImage.image = UIImage(data: image)!
            print(name)
            
        }
    }
    
    @IBAction func backBotton(_ sender: UIButton) {
 //navigationController?.isNavigationBarHidden = false
        UserDefaults.standard.set(false , forKey: "IsLoggedIn")

//        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
//
//        viewController.user = user

        self.navigationController?.popToRootViewController(animated: true)

    }
    
   
    
    @IBAction func backGOT(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
