//
//  FoodDetailViewModel.swift
//  CookApp
//
//  Created by Kim Nordin on 2021-08-13.
//

import Foundation
import SwiftUI

final class FoodDetailViewModel: ObservableObject {
    @Published var food: Food?
    @Published private var showingImage = false
      
    func setup(_ food: Food) {
        self.food = food
    }
    
    func showImage(image: UIImage?) -> Bool {
        guard image != nil else { return false }
        return true
    }
}
