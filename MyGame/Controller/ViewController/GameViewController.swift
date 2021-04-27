//
//  GameViewController.swift
//  MyGame
//
//  Created by Gilmar Queiroz on 22/04/21.
//  Copyright © 2021 Gilmar Queiroz. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var lbtitle: UILabel!
    @IBOutlet weak var lbConsole: UILabel!
    @IBOutlet weak var lbReleseDate: UILabel!
    @IBOutlet weak var ivcover: UIImageView!

    //MARK: - variable
    var game: Game!

    //MARK:- life cyclo
    override func viewDidLoad() {
        super.viewDidLoad()
     loadRequest()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRequest()
    }

    //MARK: - methods
    func loadRequest() {
        lbtitle.text = game.title
        lbConsole.text = game.console?.nome
        //formartar data
        if let releseDate = game.releseDate {
            let format = DateFormatter()
            format.dateStyle = .long
            format.locale = Locale(identifier: "pt-BR")
            lbReleseDate.text = "Lançamento " + format.string(from: releseDate)
        }

        if let image = game.cover as? UIImage {
            ivcover.image = image
        } else {
            ivcover.image = UIImage(named: "noCoverFull")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddEditViewController
        vc.game = game
    }
}

