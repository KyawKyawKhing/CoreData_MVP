//
//  HomePresenter.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/20/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
protocol HomeDelegate {
    func displayUserList(dataList:[UserData])
    func displayErrorMessage(message:String)
    func reloadData(message:String)
}
class HomePresenter {
    
    var delegate:HomeDelegate
    var userModel:UserModel = UserModel()
    
    init(delegate:HomeDelegate) {
        self.delegate = delegate
    }
    
    func getUserList(){
        userModel.getUserList(success: { (userDataList) in
            self.delegate.displayUserList(dataList: userDataList)
        }) { (errorMessage) in
            self.delegate.displayErrorMessage(message: errorMessage)
        }
    }
    
    func deleteUserData(userData:UserData){
        userModel.deleteUserData(userData: userData, success: {(successMessage) in
            self.delegate.reloadData(message: successMessage)
        }, failure: {(errorMessage) in
            self.delegate.displayErrorMessage(message: errorMessage)
        })
    }
}
