//
//  Food.swift
//  CookApp
//
//  Created by Kim Nordin on 2021-08-12.
//

import Foundation
import UIKit
import Combine

class Food: Identifiable, ObservableObject {
    @Published var name: String
    var image: UIImage? = nil
    var ingredients = [Ingredient]()
    var rating: Int? = nil
    
    init(name: String, image: UIImage? = nil, ingredients: [Ingredient], rating: Int? = nil) {
        self.name = name
        self.image = image
        self.ingredients = ingredients
        self.rating = rating
    }
    
    func correctIngredientLabel() -> String {
        if ingredients.count > 1 {
            return "\(ingredientCount()) Ingredients"
        }
        else if ingredients.count == 1 {
            return "1 Ingredient"
        }
        else {
            return "No Ingredients"
        }
    }
    
    func ingredientCount() -> String {
        return "\(ingredients.count)"
    }
    
    func stringIngredient(_ ingredient: Ingredient) -> String {
        return ingredient.description
    }
    
    func stringIngredients() -> [String] {
        var strIngredients = [String]()
        for ingredient in ingredients {
            if ingredient.description != "" {
                strIngredients.append(ingredient.description)
            }
        }
        return strIngredients
    }
}

#if DEBUG
let testFoodData = [
    Food(name: "Pizza", image: UIImage(named: "pizza"), ingredients: [testIngredientData[11], testIngredientData[12], testIngredientData[5]], rating: 4),
    Food(name: "Pasta", image: UIImage(named: "pasta"), ingredients: [testIngredientData[4], testIngredientData[5], testIngredientData[6], testIngredientData[7]], rating: 2),
    Food(name: "Tacos", image: UIImage(named: "tacos"), ingredients: [testIngredientData[8], testIngredientData[9], testIngredientData[0], testIngredientData[10]], rating: 3),
    Food(name: "Baked Beans", ingredients: [testIngredientData[4]], rating: 5)
]
#endif
