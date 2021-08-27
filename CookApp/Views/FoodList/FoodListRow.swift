//
//  FoodListRow.swift
//  CookApp
//
//  Created by Kim Nordin on 2021-08-13.
//

import SwiftUI

struct FoodListRow: View {
    @Environment(\.colorScheme) var colorScheme
    var food: Food
    var body: some View {
        HStack {
            if let image = food.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle()
                                .stroke((colorScheme == .dark ? Color.white : Color.black), lineWidth: 2))
                    .padding()
            }
            VStack(alignment: .leading) {
                Text(food.name).font(.title)
                if let rating = food.rating {
                    RatingDisplayView(rating: rating)
                }
            }
            .padding(EdgeInsets(top: 0, leading: (food.image != nil ? 0 : 20), bottom: 0, trailing: 0))
        }
        .frame(minHeight: 60)
    }
}

struct FoodListRow_Previews: PreviewProvider {
    static var previews: some View {
        FoodListRow(food: testFoodData[4])
    }
}
