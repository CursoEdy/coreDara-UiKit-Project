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
    
    //criando picker das categorias
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .white
        return picker
    }()
    
    var categoriaManager = CategoryManager.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoriaManager.loadCategoria(with: context)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if treino != nil {
            title = "Editar treino"
            btnAddEdit.setTitle("ALTERAR", for: .normal)
            tfTreino.text = treino.treino
            if let categoria = treino.category, let index = categoriaManager.categoria.firstIndex(of: categoria) {
                tfCategoria.text = categoria.categoria
                pickerView.selectRow(index, inComponent: 0, animated: true)
            }
        }
        prepareConsoletextField()
    }
    
    func prepareConsoletextField() {
        //criando toolbar da pickerView, e adicionar os botoes de cancelar e retornar
        //criando e definindo frame
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolBar.tintColor = UIColor(named: "main")
        //criando botoes
        let btnCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let btnFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //atribui um espaço entres os botoes
        //Adicionando item(botoes)  a toolBar
        toolBar.items = [btnCancel, btnFlexibleSpace, btnDone]
        tfCategoria.inputView = pickerView
        tfCategoria.inputAccessoryView = toolBar
    }
    
    @objc func cancel() {
        tfCategoria.resignFirstResponder()
    }
    
    @objc func done() {
        
        tfCategoria.text = categoriaManager.categoria[pickerView.selectedRow(inComponent: 0)].categoria
        cancel()
    }
    
    @IBAction func addEdit(_ sender: UIButton) {
        if treino == nil {
            treino = Treino(context: context)
        }
        treino.treino = tfTreino.text ?? ""
        if !tfCategoria.text!.isEmpty {
            let categoria = categoriaManager.categoria[pickerView.selectedRow(inComponent: 0)]
            treino.category = categoria
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
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriaManager.categoria.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let categoria = categoriaManager.categoria[row]
        return categoria.categoria
    }
}
