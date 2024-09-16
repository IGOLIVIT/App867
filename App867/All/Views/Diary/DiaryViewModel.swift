//
//  DiaryViewModel.swift
//  App867
//
//  Created by IGOR on 30/08/2024.
//

import SwiftUI
import CoreData

final class DiaryViewModel: ObservableObject {
    
    @AppStorage("progressActive") var progressActive: Int = 0
    
    @Published var eats: [String] = ["Breakfast", "Lunch", "Supper", "Snack"]
    @Published var currentEat = "Breakfast"
    @Published var currentEattoAdd = ""
    
    @Published var isAdd: Bool = false
    @Published var isAddCat: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    @Published var isAddTask: Bool = false
    @Published var isSettings: Bool = false
    
    @AppStorage("categoties") var categories: [String] = ["All"]
    @Published var currentCategory = "All"
    @Published var category = ""
    @Published var categoryForAdd = "All"
    
    @Published var diTitle = ""
    @Published var diDate: Date = Date()
    @Published var diTime: String = ""
    @Published var diEat = ""
    @Published var diDescr = ""
    @Published var diIng = ""

    @Published var diaries: [DiaryModel] = []
    @Published var selectedDiary: DiaryModel?

    func addDiary() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "DiaryModel", into: context) as! DiaryModel

        loan.diTitle = diTitle
        loan.diDate = diDate
        loan.diTime = diTime
        loan.diEat = diEat
        loan.diDescr = diDescr
        loan.diIng = diIng

        CoreDataStack.shared.saveContext()
    }

    func fetchDiaries() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<DiaryModel>(entityName: "DiaryModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.diaries = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.diaries = []
        }
    }
}
