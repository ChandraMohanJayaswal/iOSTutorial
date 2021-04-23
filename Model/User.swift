//
//  User.swift
//  DemoFeb13
//
//  Created by Chandra Jayaswal on 2/20/21.
//

import UIKit

class User: NSObject {
    var email: String?
    var password: String?
    
    override init() {
        self.email = ""
        self.password = ""
    }
    
    init(email:String?, password:String?) {
        self.email = email
        self.password = password
    }
    
    func validate() -> Validateion {
        let validation = Validateion.init(status: true, message: "Success")
        if !Util.validateEmail(enteredEmail: self.email ?? "") {
            validation.status = false
            validation.message = "Invalid email."
            return validation;
        }
        if self.password?.count == 0 {
            validation.status = false
            validation.message = "Empty Password"
            return validation;
        }
        return validation
    }
    
    
}
