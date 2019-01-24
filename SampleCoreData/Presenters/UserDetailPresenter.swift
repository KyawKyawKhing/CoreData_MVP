//
//  UserDetailPresenter.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/20/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
protocol UserDetailDelegate {
    func displayUpdateUserDetail(message:String)
    func displayErrorMessage(message:String)
}
class UserDetailPresenter{
    var delegate:UserDetailDelegate
    var userModel:UserModel = UserModel()
    
    init(delegate:UserDetailDelegate) {
        self.delegate = delegate
    }
    
    func updateUserData(oldData:UserData,newData:UserData){
        userModel.updateUserData(oldData:oldData,newData:newData, success: {(successMessage) in
            self.delegate.displayUpdateUserDetail(message: successMessage)
        }, failure: {(errorMessage) in
            self.delegate.displayErrorMessage(message: errorMessage)
        })
    }
}
