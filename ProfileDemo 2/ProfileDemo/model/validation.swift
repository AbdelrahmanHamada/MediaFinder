//
//  validation.swift
//  ProfileDemo
//
//  Created by a on 5/18/20.
//  Copyright © 2020 a. All rights reserved.
//

import Foundation

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}
        
func isValidPass(_ pass: String) -> Bool {
    let passRegEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
    
    let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
    return passPred.evaluate(with: pass)
}

func isValidPhone(_ phone: String) -> Bool {
    let phoneRegEx = "^[0-9+]{0,1}+[0-9]{5,16}$"
    
    let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
    return phonePred.evaluate(with: phone)
}
