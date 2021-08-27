//
//  Ingredient.swift
//  CookApp
//
//  Created by Kim Nordin on 2021-08-13.
//

import Foundation

struct Ingredient: Identifiable, Equatable {
    var id = UUID().hashValue
    var description: String
    var measure: Measurement? = nil
    
    func displayMeasure() -> String {
        let measureString = "\(measure?.amount) \(measure)"
        return measureString
    }
    
    static func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.description == rhs.description
    }
}

class Measurement {
    var amount: Int? = nil
    var measure: MeasurementType
    
    init(amount: Int? = nil, measure: MeasurementType) {
        self.amount = amount
        self.measure = measure
    }
}

enum MeasurementType: String, CaseIterable {
    case gram = "g"
    case kilo = "kg"
    case hecto = "hg"
    case count = "x"
}

#if DEBUG
let testIngredientData = [
    Ingredient(id: UUID().hashValue, description: "Cheese", measure: Measurement(amount: 2, measure: .count)),
    Ingredient(id: UUID().hashValue, description: "Tomato", measure: Measurement(amount: 5, measure: .count)),
    Ingredient(id: UUID().hashValue, description: "Basil", measure: Measurement(amount: 200, measure: .gram)),
    Ingredient(id: UUID().hashValue, description: "Pasta", measure: Measurement(amount: 500, measure: .gram)),
    Ingredient(id: UUID().hashValue, description: "Beans", measure: Measurement(amount: 200, measure: .gram)),
    Ingredient(id: UUID().hashValue, description: "Tomato sauce", measure: Measurement(amount: 200, measure: .gram)),
    Ingredient(id: UUID().hashValue, description: "Taco shells", measure: Measurement(amount: 5, measure: .count)),
    Ingredient(id: UUID().hashValue, description: "Meat", measure: Measurement(amount: 400, measure: .gram)),
    Ingredient(id: UUID().hashValue, description: "Cucumber", measure: Measurement(amount: 1, measure: .count)),
    Ingredient(id: UUID().hashValue, description: "Onion", measure: Measurement(amount: 2, measure: .count)),
    Ingredient(id: UUID().hashValue, description: "Rice", measure: Measurement(amount: 1, measure: .kilo)),
    Ingredient(id: UUID().hashValue, description: "Flour", measure: Measurement(amount: 1, measure: .kilo)),
    Ingredient(id: UUID().hashValue, description: "Mozarella", measure: Measurement(amount: 300, measure: .gram))
]
#endif
