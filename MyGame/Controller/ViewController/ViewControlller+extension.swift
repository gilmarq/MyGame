//
//  ViewControlller+extension.swift
//  MyGame
//
//  Created by Gilmar Queiroz on 23/04/21.
//  Copyright © 2021 Gilmar Queiroz. All rights reserved.
//

import UIKit
import  CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

        return appDelegate.persistentContainer.viewContext

    }

}
