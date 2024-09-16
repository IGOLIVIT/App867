//
//  ProgressViewModel.swift
//  App867
//
//  Created by IGOR on 30/08/2024.
//

import SwiftUI
import CoreData

final class ProgressViewModel: ObservableObject {
    
    @AppStorage("progressActive") var progressActive: Int = 0
    
    @AppStorage("sumGoals") var sumGoals: Int = 0

    @AppStorage("weight") var weight: String = "0"
    @AppStorage("Age") var Age: String = "0"
    @AppStorage("WU") var WU: String = "0"
    @AppStorage("fat") var fat: String = "0"
    @AppStorage("WS") var WS: String = "0"
    @AppStorage("PN") var PN: String = "0"
    
    @Published var addWeight = ""
    @Published var addAge = ""
    @Published var addWU = ""
    @Published var addFat = ""
    @Published var addWS = ""
    @Published var addPN = ""
    
    @Published var stages: [String] = ["In process", "Done"]
    @Published var currentStage = "In process"
    @Published var currentStageToAdd = ""
    
    @Published var isControl: Bool = false

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    @Published var isSettings: Bool = false

    @Published var gTitle = ""
    @Published var gDate: Date = Date()
    @Published var gDescr: String = ""
    @Published var gStage = ""

    @Published var goals: [GoalModel] = []
    @Published var selectedGoal: GoalModel?

    func addGoal() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "GoalModel", into: context) as! GoalModel

        loan.gTitle = gTitle
        loan.gDate = gDate
        loan.gDescr = gDescr
        loan.gStage = gStage

        CoreDataStack.shared.saveContext()
    }

    func fetchGoals() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<GoalModel>(entityName: "GoalModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.goals = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.goals = []
        }
    }
}
