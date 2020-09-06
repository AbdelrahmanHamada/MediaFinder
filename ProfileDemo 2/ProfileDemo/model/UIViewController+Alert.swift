//
//  UIViewController+Alert.swift
//  MediaFinder
//
//  Created by a on 6/2/20.
//  Copyright © 2020 a. All rights reserved.
//

import UIKit
extension UIViewController {
    func alert(tital: String , messge : String ) {
        let alert = UIAlertController(title: tital, message: messge, preferredStyle: .alert)
        let action = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
}
