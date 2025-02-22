//
//  AddEditViewController.swift
//  CoreDataProject
//
//  Created by ednardo alves on 16/02/25.
//

import UIKit

class AddEditViewController: UIViewController {

    @IBOutlet weak var tfTreino: UITextField!
    @IBOutlet weak var tfCategoria: UITextField!
    @IBOutlet weak var btnAddEdit: UIButton!
    
    var treino: Treino!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addEdit(_ sender: UIButton) {
        if treino == nil {
            treino = Treino(context: context)
        }
        treino.treino = tfTreino.text ?? ""
        
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
