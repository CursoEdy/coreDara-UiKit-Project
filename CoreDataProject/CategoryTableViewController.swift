//
//  CategoryTableViewController.swift
//  CoreDataProject
//
//  Created by ednardo alves on 16/02/25.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    var categoriaManager = CategoryManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategoria()
    }
    
    func loadCategoria() {
        categoriaManager.loadCategoria(with: context)
        tableView.reloadData()
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        showAlert(with: nil)
    }
    
    func showAlert(with categoria: Categoria?) {
        let title = categoria == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + " Categoria", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Digite o nome da categoria"
            if let categoria = categoria?.categoria {
                textField.text = categoria
            }
        }
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            let categoria = categoria ?? Categoria(context: self.context)
            categoria.categoria = alert.textFields?.first?.text ?? ""
            do {
                do {
                    try self.context.save()
                    self.loadCategoria()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.view.tintColor = UIColor(named: "second")
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    //Como teremos apenas um section, podemos comentar esta funcao
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoriaManager.categoria.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let categorias = categoriaManager.categoria[indexPath.row]
        cell.textLabel?.text = categorias.categoria
        
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
