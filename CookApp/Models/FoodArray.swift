//
//  FoodArray.swift
//  CookApp
//
//  Created by Kim Nordin on 2021-08-12.
//

import Foundation

class FoodArray: ObservableObject {
    
    @Published var list = [Food]()
    
    var count : Int {
        return list.count
    }
    
    func addFood(food: Food) {
        list.append(food)
    }
    
    func clearFood() {
        list.removeAll()
    }
    
    func deleteFood(index: Int){
        list.remove(at: index)
    }
    
    func entry(index: Int) -> Food? {
        
        if index >= 0 && index <= list.count {
            return list[index]
        }
        
        return nil
    }
}
