//
//  File.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/20/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
protocol AddUserDelegate {
    func displaySuccessfulMessage(message:String)
    func displayErrorMessage(message:String)
}
class AddUserPresenter {
    
    var delegate:AddUserDelegate
    var userModel:UserModel = UserModel()
    
    init(delegate:AddUserDelegate) {
        self.delegate = delegate
    }
    
    func addUserData(userData:UserData){
        userModel.addUserData(userData: userData, success: {(successMessage) in
            self.delegate.displaySuccessfulMessage(message: successMessage)
        }, failure: {(errorMessage) in
            self.delegate.displayErrorMessage(message: errorMessage)
        })
    }
}
