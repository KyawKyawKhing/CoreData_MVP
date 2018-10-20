//
//  UserModelCallback.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/20/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
//C -> Create Callback
protocol AddUserCallback {
    func SuccedAddUser(message:String)
    func FailedAddUser(message:String)
}
//R -> Read Callback
protocol GetUserListCallback {
    func SucceedGetUserList(dataList:[UserData])
    func FailedGetUserList(message:String)
}
//U -> Update Callback
protocol UpdateUserCallback {
    func SucceedUpdateUser(data:UserData,messsage:String)
    func FailedGetUpdate(message:String)
}
//D -> Delete Callback
protocol DeleteUserCallback {
    func SuccedDeleteUser(message:String)
    func FailedDeleteUser(message:String)
}
