//
//  Validateion.swift
//  DemoFeb13
//
//  Created by Chandra Jayaswal on 2/20/21.
//

import UIKit

class Validateion: NSObject {
    
    var status:Bool
    var message:String
    
    override init() {
        self.status = false
        self.message = ""
    }
    
    init(status:Bool, message:String) {
        self.status = status
        self.message = message
    }
}
