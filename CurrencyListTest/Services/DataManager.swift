//
//  DataManager.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 14.08.2021.
//

import Foundation
import UIKit
import CoreData

class DataManager {
                  
    func fetchCDData() -> Double? {
                        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataTexts.coreDataEntityName)
        
        do {
            let limit = try managedContext.fetch(fetchRequest)
            if limit.isEmpty {
                return nil
            } else {
                if let current = limit[limit.count - 1].value(forKey: CoreDataTexts.coreDataEntityName) {
                    return current as? Double
                }
            }
        } catch let error as NSError {
            print("\(CoreDataTexts.errorReadText) \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func saveData(value: Double) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataTexts.coreDataEntityName, in: managedContext)!
        let limit = NSManagedObject(entity: entity, insertInto: managedContext) as! LimitPrice
        limit.limitPrice = value
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("\(CoreDataTexts.errorSaveText) \(error), \(error.userInfo)")
        }
    }
   
}
