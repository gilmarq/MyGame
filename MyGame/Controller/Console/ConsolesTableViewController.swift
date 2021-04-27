//
//  ConsolesTableViewController.swift
//  MyGame
//
//  Created by Gilmar Queiroz on 22/04/21.
//  Copyright © 2021 Gilmar Queiroz. All rights reserved.
//

import UIKit

class ConsolesTableViewController: UITableViewController {

    //MARK: - variable
    var consoleManager = ConsoleManeger.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        loadConsole()
    }

    @IBAction func addConsole(_ sender: UIBarButtonItem) {
        showAlert(with: nil)
    }

    //MARK: - methods
    func loadConsole() {
        consoleManager.loadConsole(with: context)
        tableView.reloadData()
    }

    func showAlert(with console: Console?) {

        let title = console == nil ? "Adiciona": "Editar"
        let alert = UIAlertController(title: title + "Plataforma", message: nil, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "nome da plataforma"
            if let name = console?.nome {
                textField.text = name
            }
        }

        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            let console = console ?? Console(context: self.context)
            console.nome = alert.textFields?.first?.text
            do {
                try self.context.save()
                self.loadConsole()

            } catch {
                print(error.localizedDescription)
            }
        }))
        alert.addAction(UIAlertAction(title: "Canelar", style: .cancel, handler: nil))
        alert.view.tintColor = UIColor(named: "second")

        present(alert,animated: true,completion: nil)


    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return consoleManager.consoles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let console = consoleManager.consoles[indexPath.row]
        cell.textLabel?.text = console.nome

        return cell
    }


    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
