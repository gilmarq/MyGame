//
//  ConsoleManeger.swift
//  MyGame
//
//  Created by Gilmar Queiroz on 26/04/21.
//  Copyright © 2021 Gilmar Queiroz. All rights reserved.
//

import Foundation
import CoreData


class ConsoleManeger  {
    //MARK: -  variable
    static let shared = ConsoleManeger()
    var consoles: [Console] = []

    //MARK: - init
    private init() {

    }

    //MARK: - methods
    func loadConsole(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Console> = Console.fetchRequest()
        let shortDescription = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [shortDescription]

        do {
            consoles = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteConsole(index:Int , context: NSManagedObjectContext) {
        let console = consoles[index]
        context.delete(console)
        consoles.remove(at: index)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
