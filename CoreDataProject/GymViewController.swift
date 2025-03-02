//
//  GymViewController.swift
//  CoreDataProject
//
//  Created by ednardo alves on 16/02/25.
//

import UIKit

class GymViewController: UIViewController {
    
    @IBOutlet weak var lbCategoria: UILabel!
    @IBOutlet weak var lbTreino: UILabel!
    
    var treino: Treino!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbCategoria.text = treino.category?.categoria
        lbTreino.text = treino.treino
        //exemplo de uso de data caso exista uam lbDate
//        if let releaseDatae = treino.dataLancamento {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .long
//            dateFormatter.locale = Locale(identifier: "pt-BR")
//            lbData.text = dateFormatter.string(from: releaseDatae)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //seta a view de destino para receber os dados
        let vc = segue.destination as! AddEditViewController
        
        //passa o treino dessa view para o treino da view destinada
        vc.treino = treino
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
