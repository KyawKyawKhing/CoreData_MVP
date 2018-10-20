//
//  File.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/20/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
protocol AddUserDelegate {
    func displaySuccessfuleMessage(message:String)
    func displayErrorMessage(message:String)
}
class AddUserPresenter:AddUserCallback {
    
    var delegate:AddUserDelegate
    var userModel:UserModel = UserModel()
    
    init(delegate:AddUserDelegate) {
        self.delegate = delegate
    }
    
    func addUserData(userData:UserData){
        userModel.addUserData(userData: userData, callback: self)
    }
  
    func SuccedAddUser(message: String) {
        delegate.displaySuccessfuleMessage(message: message)
    }
    
    func FailedAddUser(message: String) {
        delegate.displayErrorMessage(message: message)
    }
    
}
