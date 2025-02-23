//
//  CategoryManager.swift
//  CoreDataProject
//
//  Created by ednardo alves on 23/02/25.
//

import CoreData

class CategoryManager {
    
    static let shared = CategoryManager()
    var categoria: [Categoria]
    
    func loadCategoria(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Categoria> = Categoria.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "categoria", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            categoria = try context.fetch(fetchRequest)
        } catch {
            print("Erro ao carregar categorias: \(error.localizedDescription)")
//            categoria = []
        }
    }
    
    func deleteCategoria(at index: Int, with context: NSManagedObjectContext) {
        guard index >= 0 && index < categoria.count else { return }
        let categoriaParaDeletar = categoria[index]
        context.delete(categoriaParaDeletar)
        do {
            try context.save()
        } catch {
            print("Erro ao deletar categoria: \(error.localizedDescription)")
        }
    }
    
    private init() {
        self.categoria = []
    }
}
