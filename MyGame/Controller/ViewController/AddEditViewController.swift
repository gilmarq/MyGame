//
//  AddEditViewController.swift
//  MyGame
//
//  Created by Gilmar Queiroz on 22/04/21.
//  Copyright © 2021 Gilmar Queiroz. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfConsole: UITextField!
    @IBOutlet weak var dpReleseDate: UIDatePicker!
    @IBOutlet weak var addEdit: UIButton!
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var addEditCover: UIButton!

    //MARK: - variable
    var game: Game!

    //MARK: = life cyclo
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: -action
    @IBAction func addEditCover(_ sender: Any) {
    }

    @IBAction func addEditGame(_ sender: Any) {
        if game == nil  {
            game = Game(context: context)
        }
        game.title = tfTitle.text
        game.releseDate = dpReleseDate.date

        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        navigationController?.popViewController(animated: true)
    }

    

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
