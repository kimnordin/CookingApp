//
//  FoodListViewModel.swift
//  CookApp
//
//  Created by Kim Nordin on 2021-08-12.
//

import Foundation

final class FoodListViewModel: ObservableObject {
    var foodData: FoodArray?
      
    func setup(_ foodData: FoodArray) {
        self.foodData = foodData
    }
    
    func addTestData() {
        self.foodData?.list = foodTestData
    }
    
    func move(indices: IndexSet, newOffset: Int) {
        foodData?.list.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func delete(at index: IndexSet) {
        for i in index {
            foodData?.list.remove(at: i)
        }
    }
}
