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
    let consoleManage = ConsoleManeger.shared
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()

    //MARK: = life cyclo
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        consoleManage.loadConsole(with: context)
        tfConsole.inputView = pickerView
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

extension AddEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return consoleManage.consoles.count
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
     return 1

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let console = consoleManage.consoles[row]
        return console.nome
    }


}
