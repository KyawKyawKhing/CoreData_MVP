//
//  Utils.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/20/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
import UIKit
class Utils{
    static func showAlert(viewcontroller:UIViewController,title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    
    static func showAlert(viewcontroller:UIViewController,title:String,message:String,action:@escaping ()->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
        action()
        })
        alert.addAction(okAction)
        viewcontroller.present(alert, animated: true, completion: nil)
    }
}
