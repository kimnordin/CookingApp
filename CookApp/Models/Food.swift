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
let foodTestData = [
    Food(name: "Pizza", image: UIImage(named: "pizza"), ingredients: [ingredientTestData[0], ingredientTestData[1], ingredientTestData[2]], rating: 4),
    Food(name: "Pasta", image: UIImage(named: "pasta"), ingredients: [ingredientTestData[4], ingredientTestData[5], ingredientTestData[6], ingredientTestData[7]], rating: 2),
    Food(name: "Tacos", image: UIImage(named: "tacos"), ingredients: [ingredientTestData[8], ingredientTestData[9], ingredientTestData[0], ingredientTestData[10]], rating: 3),
    Food(name: "Baked Beans", ingredients: [ingredientTestData[4]], rating: 5)
]
#endif
