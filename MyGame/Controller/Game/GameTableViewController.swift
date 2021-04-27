//
//  GameTableViewController.swift
//  MyGame
//
//  Created by Gilmar Queiroz on 23/04/21.
//  Copyright © 2021 Gilmar Queiroz. All rights reserved.
//

import UIKit
import CoreData

class GameTableViewController: UITableViewController {

    //MARK: - variable
    var label = UILabel()
    var fetchedResultsController: NSFetchedResultsController<Game>!
    let searchController = UISearchController(searchResultsController:nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGames()
        setupLabel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        setupSearchController()
    }

    //MARL: - Methods
    func setupLabel() {
        label.text = "Você não tem jogos cadastrado"
        label.textAlignment = .center
    }

    func  loadGames(flitter: String = "") {
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        let shortDescription = NSSortDescriptor(key: "title", ascending: true)

        if !flitter.isEmpty {
            let preticate = NSPredicate(format: "title contains [c] %@", flitter)
            fetchRequest.predicate = preticate
        }

        fetchRequest.sortDescriptors = [shortDescription]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath:nil, cacheName: nil)
        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "gameSegue" {
            let vc =  segue.destination as! GameViewController

            if let games = fetchedResultsController.fetchedObjects {
                vc.game = games[tableView.indexPathForSelectedRow!.row]
            }
        }
    }

    func setupSearchController() {
        // searchController programaticamente para pesquisa
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultsController.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? label : nil

        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameTableViewCell
        guard let game = fetchedResultsController.fetchedObjects?[indexPath.row] else { return cell }
        cell.prepare(with: game)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let game = fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
            context.delete(game)
        }
    }
}

//MARK: - NSFetchedResultsControllerDelegate
extension GameTableViewController: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .delete:
                if let indexPath = indexPath {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                break
            default:
                tableView.reloadData() 
        }
    }
}
//MARK: - UISearchResultsUpdating UISearchBarDelegate
extension GameTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {

    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadGames()
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadGames(flitter: searchBar.text!)
        tableView.reloadData()
    }



}
