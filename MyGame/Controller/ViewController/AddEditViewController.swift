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
        pickerView.backgroundColor = .white
        return pickerView
    }()

    //MARK: = life cyclo
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        consoleManage.loadConsole(with: context)
        setupTextField()

    }
    //MARK: - methods

    func setupTextField() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.tintColor = UIColor(named: "main")
        //botões do picker
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        //btFexbleSpace de espaço entre os botões
        let btFexbleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
        toolbar.items = [btCancel, btFexbleSpace, btDone]

        tfConsole.inputView = pickerView
        tfConsole.inputAccessoryView = toolbar
    }

    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.navigationBar.tintColor = UIColor(named: "main")
        present(imagePicker, animated: true,completion: nil)




    }


    @objc func cancel() {
        tfConsole.resignFirstResponder()
    }

    @objc func done() {
        tfConsole.text = consoleManage.consoles[pickerView.selectedRow(inComponent: 0)].nome
        cancel()

    }

    //MARK: -action
    @IBAction func addEditCover(_ sender: Any) {

        let alert = UIAlertController(title: "Selecione poster", message: "De onde você quer escolher o poste", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default, handler:{ (action: UIAlertAction) in
                self.selectPicture(sourceType: .camera)
            })
            alert.addAction(cameraAction)
        }
        let libraryAction = UIAlertAction(title: "Bibliateca de fotos", style: .default, handler:{ (action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        })
        alert.addAction(libraryAction)
        let photoAction = UIAlertAction(title: "Álbum de fotos", style: .default, handler:{ (action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        })
        alert.addAction(photoAction)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler:nil)
        alert.addAction(cancelAction)
        present(alert,animated: true, completion: nil)

    }

    @IBAction func addEditGame(_ sender: Any) {
        if game == nil  {
            game = Game(context: context)
        }
        game.title = tfTitle.text
        game.releseDate = dpReleseDate.date
        game.cover = ivCover.image

        if !tfConsole.text!.isEmpty {
            let console = consoleManage.consoles[pickerView.selectedRow(inComponent: 0)]
            //para simplificar este app so pegara fotos da galeria
            game.console = console
        }

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

extension AddEditViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        ivCover.image = image
        addEditCover.setTitle(nil, for: .normal)
        dismiss(animated: true, completion: nil)
    }

}
