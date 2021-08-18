//
//  NewFoodViewModel.swift
//  CookApp
//
//  Created by Kim Nordin on 2021-08-13.
//

import Foundation
import SwiftUI

final class NewFoodViewModel: ObservableObject {
    var foodData: FoodArray?
    @Published var alertItem: AlertItem?
    @Published var name: String = ""
    @Published var uiImage: UIImage? = nil
    @Published var rating: Int = 0
    @Published var selectedIngredient: Ingredient?
    @Published var ingredientDescription: String?
    @Published var ingredients = [Ingredient]()
    @Published var showAction: Bool = false
    @Published var showImagePicker: Bool = false
    @Published var foodCreated: Bool = false
    @Published var changeAlert: Bool = false
    
    var sheet: ActionSheet {
        ActionSheet(
            title: Text("Action"),
            message: Text("Update Image"),
            buttons: [
                .default(Text("Change"), action: {
                    self.dismissActionSheet()
                    self.displayImagePicker()
                }),
                .cancel(Text("Close"), action: {
                    self.dismissActionSheet()
                }),
                .destructive(Text("Remove"), action: {
                    self.dismissActionSheet()
                    self.uiImage = nil
                })
            ])
    }
    
    func setup(_ foodData: FoodArray) {
        self.foodData = foodData
    }
    
    func displayActionSheet() {
        showAction = true
    }
    
    func dismissActionSheet() {
        showAction = false
    }
    
    func displayImagePicker() {
        showImagePicker = true
    }
    
    func dismissImagePicker() {
        showImagePicker = false
    }
    
    func selectedTag(_ tag: Tag) {
        selectedIngredient = tag.ingredient
        changeAlert = true
    }
    
    func stringIngredients() -> [String] {
        var strIngredients = [String()]
        for ingredient in ingredients {
            if ingredient.description != "" {
                strIngredients.append(ingredient.description)
            }
        }
        return strIngredients
    }
    
    func addIngredient(_ name: String, measure: Measurement? = nil) {
        if canCreate(ingredient: Ingredient(description: name, measure: measure)) {
            ingredients.append(Ingredient(description: name, measure: measure))
        }
        print("ingredients: ", ingredients)
    }
    
    func removeIngredient(ingredient: Ingredient) {
        if let index = ingredients.firstIndex(of: ingredient) {
            ingredients.remove(at: index)
        }
    }
    
    func changeIngredient(_ text: String) {
        if let tag = selectedIngredient {
            if text != "" {
                removeIngredient(ingredient: tag)
                addIngredient(text, measure: tag.measure)
            }
            else {
                removeIngredient(ingredient: tag)
            }
        }
    }
    
    func setRating(_ score: Int) {
        rating = score
    }
    
    private func isFoodValid(name: String) -> Bool {
        if name != "" {
            print("Valid")
            return true
        }
        else if name == ""  {
            alertItem = AlertContext.NewFood.noName
        }
        return false
    }
    

    func createFood(name: String, image: UIImage? = nil, ingredients: [Ingredient], rating: Int? = nil) {
        if isFoodValid(name: name) {
            foodData?.addFood(food: Food(name: name, image: image, ingredients: ingredients, rating: rating))
            foodCreated = true
        }
        else {
            foodCreated = false
        }
    }
    
    // Check for duplicates before adding Ingredient
    func canCreate(ingredient: Ingredient) -> Bool {
        var descriptionList = [String]()
        if ingredient.description.isEmpty {
            return false
        }
        for ingredient in ingredients {
            descriptionList.append(ingredient.description)
        }
        
        if ingredients.contains(where: { $0.description.localizedCaseInsensitiveContains(ingredient.description) }) {
            return false
        }
        return true
    }
}
