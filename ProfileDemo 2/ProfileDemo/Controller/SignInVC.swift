//
//  SignInVC.swift
//  ProfileDemo
//
//  Created by a on 5/13/20.
//  Copyright © 2020 a. All rights reserved.
//

import UIKit


class SignInVC: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passText: UITextField!
    
    @IBOutlet weak var signInBottonDisgen: UIButton!
    
    
    
   var user : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = "Sign In Screen"
        
        if let email = UserDefaults.standard.object(forKey: "email") as? String {
            emailText.text = email
        }
       DataBaseManager.shared.connectDataBase()
        signInBottonDisgen.layer.cornerRadius = signInBottonDisgen.frame.height / 2
        self.HideKeyboard()
      //  DataBaseManager.shared.listUsers()
       // DataBaseManager.shared.listUsers()
    }
    
    
    @IBAction func showOrHidePass(_ sender: UIButton) {
        
        if passText.isSecureTextEntry == true {
                    passText.isSecureTextEntry = false
               }else {
                   passText.isSecureTextEntry = true
               }
        
    }
    
    
    
    @IBAction func signInBotton(_ sender: UIButton) {
               var email: String?
               var pass: String?
               
               if emailText.text!.isEmpty || passText.text!.isEmpty {
                alert(tital: "Fields Required", messge: "")
               }
               
        DataBaseManager.shared.filterTableOfUsers(emailTextField: emailText.text!.lowercased(), handle: {
                   selected in
        
                   email = selected[DataBaseManager.shared.email]
                   pass = selected[DataBaseManager.shared.pass]
                   
               })
                       
        if  email == emailText.text  &&  pass == passText.text {
            UserDefaults.standard.set(true, forKey: CasheKey().isLoggedIn)
            let gotVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviesVC") as! MoviesVC
                   self.navigationController?.pushViewController(gotVC, animated: true)
         UserDefaults.standard.set(emailText.text?.lowercased(), forKey: constants().lastLoginAccontEmail)
        }
        else {

  alert(tital: "Attention", messge: "Invaled cerdintials" )
        
                }
    
            }
        }


    

