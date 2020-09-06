//
//  ViewController.swift
//  ProfileDemo
//
//  Created by a on 5/13/20.
//  Copyright © 2020 a. All rights reserved.
//

import UIKit


class SignUpVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailTaxt: UITextField!
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var phoneNumText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var signUpBottonDisgen: UIButton!
    @IBOutlet weak var genderLable: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var validationLable: UILabel!
    @IBOutlet weak var validationPass: UILabel!
    @IBOutlet weak var validationPhone: UILabel!
   //  var address1 = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Sign Up Screen"
         myImageView.layer.cornerRadius=myImageView.frame.size.width/2
        signUpBottonDisgen.layer.cornerRadius = signUpBottonDisgen.frame.height / 2
        self.HideKeyboard()
        //addressText?.text = address1
    }
    @IBAction func SignUpBotton(_ sender: UIButton) {

        guard let email = emailTaxt.text , !email.isEmpty , let pass = passText.text , !pass.isEmpty  , let phone = phoneNumText.text , !phone.isEmpty else {
            

              alert(tital: "Attention", messge: "Email , password and phone are recoired" )
           return
          
        }
        
        UserDefaults.standard.set(emailTaxt.text , forKey: "email")
        
        
        let signInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        UserDefaults.standard.set(true, forKey: "IsLoggedIn")
        
        let user = User(name: nameText.text ?? "", email: emailTaxt.text ?? "", password: passText.text ?? "", phoneNum: phoneNumText.text ?? "", gender :  genderLable.text!, address: addressText.text ?? "" , image: Image(withImage: myImageView.image!) )
        
        DataBaseManager.shared.insertUser(user: user) { (Error) in
            
        }
       
       if isValidEmail(email) && isValidPass(pass) && isValidPhone(phone) {
                 validationLable.isHidden = false
                 validationPass.isHidden = false
                 validationPhone.isHidden = false
                 self.navigationController?.pushViewController(signInVC, animated: true)
        UserDefaults.standard.set(true, forKey: CasheKey().signedUp)
       }
      
                 
         else if isValidEmail(email) == false {
                 
                 validationLable.text = "enter a valid email "
                 
                 
             } else if isValidPass(pass) == false {
                 validationPass.text = "enter a valid password "
             } else {
                 validationPhone.text = "enter a valid phone number "
                 
             
        }
        signInVC.user = user
        
    }
    
    @IBAction func genderSwitch(_ sender: UISwitch) {
        
        if sender.isOn {
            genderLable.text = "Male"
        } else {
            genderLable.text = "Female"
        }
        
    }
    
    @IBAction func addPhotoBotton(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        myImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openMap(_ sender: Any) {
        let map = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapVC") as! MapVC
        map.delegate = self
        self.navigationController?.pushViewController(map, animated: true)
    }
    
}
   
    
extension SignUpVC: AddressDelegate {
    func sendAddress(address: String) {
        addressText.text = address
    }
    
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func saveName(){
//        UserDefaults.standard.set(nameText.text!, forKey: key.name)
//        UserDefaults.standard.set(emailTaxt.text!, forKey: key.email)
//        UserDefaults.standard.set(passText.text!, forKey: key.pass)
//        UserDefaults.standard.set(addressText.text!, forKey: key.address)
//        UserDefaults.standard.set(phoneNumText.text!, forKey: key.phoneNumber)
//
//    }
//
//    func CheackForName(){
//        let userName = UserDefaults.standard.value(forKey: key.name) as? String ?? " "
//        nameText.text = userName
//        let userEmail = UserDefaults.standard.value(forKey: key.email) as? String ?? " "
//        emailTaxt.text = userEmail
//        let userpass = UserDefaults.standard.value(forKey: key.pass) as? String ?? " "
//        passText.text = userpass
//        let userAD = UserDefaults.standard.value(forKey: key.address) as? String ?? " "
//        addressText.text = userAD
//        let userPhone = UserDefaults.standard.value(forKey: key.phoneNumber) as? String ?? " "
//        phoneNumText.text = userPhone
//
//    }
    


    

    
    
    
    


