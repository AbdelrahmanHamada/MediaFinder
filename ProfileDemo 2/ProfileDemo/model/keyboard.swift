//
//  keyboard.swift
//  ProfileDemo
//
//  Created by a on 5/19/20.
//  Copyright © 2020 a. All rights reserved.
//


import UIKit

extension UIViewController {
    func HideKeyboard(){
        let Tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    @objc func DismissKeyboard () {
        view.endEditing(true)
    }
}
//enum Action {
//    case push
//    case pop
//    case noThing
//}
//enum Screens :String {
//    case SignUpVC
//    case SignInVC
//    case ProfileVC
//    case MoviesVC
//    case PlayerViewController
//}
//
//
//struct Navigation {
//    
//var mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//    
//func instantiateViewController(
//                    Controller : Screens,
//                    Action : Action,
//                    Navigation :UINavigationController,
//                    action : @escaping ((UIViewController) -> Void))
//    {
//
//    let NavigationController :UINavigationController? = Navigation
//    
//    let viewController = mainStoryBoard.instantiateViewController(identifier: Controller.rawValue)
//
//    action(viewController)  // passing Data in this Closure
//
//    if Action == .push {
//            NavigationController?.pushViewController(viewController, animated: true)
//        }
//        
//    if Action == .pop {
//            NavigationController?.popViewController(animated: true)
//        }
//        
//    }
//
//
//}
//
//
