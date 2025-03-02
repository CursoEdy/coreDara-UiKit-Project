//
//  GymTableViewController.swift
//  CoreDataProject
//
//  Created by ednardo alves on 16/02/25.
//

import UIKit
import CoreData

class GymTableViewController: UITableViewController {
    
    var fetchedResultsController: NSFetchedResultsController<Treino>!
    
    // deixar um msg padrao caso a lista de treino esteja vazia
    var label = UILabel()
    let searchController = UISearchController(searchResultsController: nil)
    
    var treino: Treino!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Vc nao possui nenhum treino no momento."
        label.textAlignment = .center
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .systemBlue
        searchController.searchBar.barTintColor = .systemBlue
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadTreino()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "listaSegue" {
            let vc = segue.destination as! GymViewController
            
            if let treinos = fetchedResultsController.fetchedObjects {
                vc.treino = treinos[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    func loadTreino(filter: String = "") {
        let fetchRequest: NSFetchRequest<Treino> = Treino.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "treino", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if !filter.isEmpty {
            let predicado = NSPredicate(format: "treino contains [cd] %@", filter)
            fetchRequest.predicate = predicado
        }
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = fetchedResultsController.fetchedObjects?.count ?? 0
        
        tableView.backgroundView = count == 0 ? label : nil
        
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GymTableViewCell

        // Configure the cell...
        guard let treino = fetchedResultsController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        
        cell.prepare(with: treino)
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //primeiro recuperamos o treino
            guard let treino = fetchedResultsController.fetchedObjects?[indexPath.row] else {
                return
            }
            // Apos excluirmos o treino da lista
            // vamos precisar tbm excluir a linha na tabela
            // exclusao na tabale efetuada na extension no final do arquivo
            context.delete(treino)
        } 
    }

}

extension GymTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any,at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
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

extension GymTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadTreino()
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadTreino(filter: searchBar.text!)
        tableView.reloadData()
    }
}
