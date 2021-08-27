//
//  CookAppApp.swift
//  CookApp
//
//  Created by Kim Nordin on 2021-08-12.
//

import SwiftUI

@main
struct CookAppApp: App {
    @StateObject private var foodData = FoodArray()
    var body: some Scene {
        WindowGroup {
            FoodListView()
                .environmentObject(foodData)
        }
    }
}
