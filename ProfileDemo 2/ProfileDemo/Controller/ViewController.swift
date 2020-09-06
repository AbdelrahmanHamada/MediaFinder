//
//  ViewController.swift
//  ProfileDemo
//
//  Created by a on 5/13/20.
//  Copyright © 2020 a. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
 var user : User!
    @IBOutlet weak var appPhoto: UIImageView!
    @IBOutlet weak var signup2: UIButton!
    @IBOutlet weak var signin2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home"
        appPhoto.layer.cornerRadius = appPhoto.frame.size.width/2
        signup2.layer.cornerRadius = signup2.frame.height / 2
        signin2.layer.cornerRadius = signin2.frame.height / 2
//        if UserDefaults.standard.bool(forKey: "IsLoggedIn") == true {
//            let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GotVC") as! GotVC
//            self.navigationController?.pushViewController(profileVC, animated: false)
//        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
