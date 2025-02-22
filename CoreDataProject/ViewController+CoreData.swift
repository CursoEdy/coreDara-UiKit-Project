//
//  ViewController+CoreData.swift
//  CoreDataProject
//
//  Created by ednardo alves on 16/02/25.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
