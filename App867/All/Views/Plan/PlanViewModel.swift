//
//  PlanViewModel.swift
//  App867
//
//  Created by IGOR on 30/08/2024.
//

import SwiftUI
import CoreData

final class PlanViewModel: ObservableObject {
    
    @AppStorage("progressActive") var progressActive: Int = 0
    
    @Published var types: [String] = ["Training", "Food"]
    @Published var currentType = "Training"
    @Published var currentTypeForAdd = ""
    
    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    @Published var isSettings: Bool = false
    
    @AppStorage("categoties") var categories: [String] = ["All"]
    @Published var currentCategory = "All"
    @Published var category = ""
    @Published var categoryForAdd = "All"
    
    @Published var plTitle = ""
    @Published var plDate: Date = Date()
    @Published var plDescr: String = ""
    @Published var plIng = ""
    @Published var plType = ""

    @Published var plans: [PlanModel] = []
    @Published var selectedPlan: PlanModel?

    func addPlan() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "PlanModel", into: context) as! PlanModel

        loan.plTitle = plTitle
        loan.plDate = plDate
        loan.plDescr = plDescr
        loan.plIng = plIng
        loan.plType = plType

        CoreDataStack.shared.saveContext()
    }

    func fetchPlans() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PlanModel>(entityName: "PlanModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.plans = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.plans = []
        }
    }
}
