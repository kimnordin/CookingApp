//
//  FoodDetailView.swift
//  CookApp
//
//  Created by Kim Nordin on 2021-08-12.
//

import SwiftUI

struct FoodDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showingImage = false
    @State private var showDialog = true
    var food: Food
    var body: some View {
        GeometryReader { geo in
            ScrollView(showsIndicators: false) {
                if let image = food.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke((colorScheme == .dark ? Color.white : Color.black), lineWidth: 4))
                        .shadow(radius: 10)
                        .padding()
                        .frame(width: geo.size.width)
                    
                }
                Text(food.correctIngredientLabel())
                    .font(.headline)
                    .padding()
                HStack {
                    if !food.ingredients.isEmpty {
                        TagView(tags: food.stringIngredients(), callback: {_ in})
                        .lineLimit(1)
                        .padding()
                    }
                }
                Spacer()
            }
            .fixFlickering()
            .navigationBarTitle(Text(food.name))
        }
    }
}

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(food: testFoodData[4])
    }
}
