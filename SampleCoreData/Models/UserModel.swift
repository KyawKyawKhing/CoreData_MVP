//
//  UserModel.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/20/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UserModel{
    var managedContext:NSManagedObjectContext!
    var insertUser:NSManagedObject!
    var fetchRequest:NSFetchRequest<NSFetchRequestResult>!
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        insertUser = NSManagedObject(entity: userEntity, insertInto: managedContext)
        fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    }
    
    func getUserList(success: @escaping ([UserData]) -> Void,failure: @escaping (String) -> Void) {
        do {
            fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
            var dataArray:[UserData] = []
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                if (data.value(forKey: "name") != nil){
                print(data.value(forKey: "name") as! String)
                var userData:UserData = UserData(name: "",email: "",address: "",phone: "",education: "",bio: "")
                userData.name = data.value(forKey: "name") as! String
                userData.email = data.value(forKey: "email") as! String
                userData.address = data.value(forKey: "address") as! String
                userData.phone = data.value(forKey: "phone") as! String
                userData.education = data.value(forKey: "education") as! String
                userData.bio = data.value(forKey: "bio") as! String
                dataArray.append(userData)
                }
            }
            success(dataArray)
            
        } catch let error as NSError  {
            failure(error.localizedDescription)
        }
        
    }
    
    func addUserData(userData:UserData,success: @escaping (String) -> Void,failure: @escaping (String) -> Void){
        insertUser.setValue(userData.name, forKeyPath: "name")
        insertUser.setValue(userData.email, forKey: "email")
        insertUser.setValue(userData.address, forKey: "address")
        insertUser.setValue(userData.phone, forKey: "phone")
        insertUser.setValue(userData.education, forKey: "education")
        insertUser.setValue(userData.bio, forKey: "bio")
        do {
            try managedContext.save()
            success("Successfully Added UserData")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            failure(error.localizedDescription)
        }
    }
    
    
    func updateUserData(oldData:UserData,newData:UserData,success: @escaping (String) -> Void,failure: @escaping (String) -> Void){
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "name = %@", oldData.name)
        fetchRequest.predicate = NSPredicate(format: "email = %@", oldData.email)
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(newData.name, forKey: "name")
            objectUpdate.setValue(newData.email, forKey: "email")
            objectUpdate.setValue(newData.address, forKey: "address")
            objectUpdate.setValue(newData.phone, forKey: "phone")
            objectUpdate.setValue(newData.education, forKey: "education")
            objectUpdate.setValue(newData.bio, forKey: "bio")
            do{
                try managedContext.save()
                success("Successfully Added UserData")
            }
            catch
            {
                print(error)
                failure(error.localizedDescription)
            }
        }
        catch
        {
            print(error)
            failure(error.localizedDescription)
        }
    }
    func deleteUserData(userData:UserData,success: @escaping (String) -> Void,failure: @escaping (String) -> Void){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "name = %@", userData.name)
        fetchRequest.predicate = NSPredicate(format: "email = %@", userData.email)
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
                success("Successfully Deleted")
            }
            catch
            {
                print(error)
                failure(error.localizedDescription)
            }
            
        }
        catch
        {
            print(error)
            failure(error.localizedDescription)
        }
    }
    
}


