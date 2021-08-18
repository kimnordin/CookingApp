//
//  FoodListView.swift
//  CookApp
//
//  Created by Kim Nordin on 2021-08-12.
//

import SwiftUI

struct FoodListView: View {
    @ObservedObject var viewModel: FoodListViewModel
    @EnvironmentObject var foods: FoodArray
    @State private var presentNew = false
    var body: some View {
        NavigationView {
            List {
                ForEach(foods.list) { food in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination: FoodDetailView(viewModel: FoodDetailViewModel(), food: food)) {
                        }
                        .opacity(0)
                        FoodListRow(food: food)
                    }
                }
                .onMove(perform: { indices, newOffset in
                    viewModel.move(indices: indices, newOffset: newOffset)
                })
                .onDelete(perform: { index in
                    viewModel.delete(at: index)
                })
            }
            .background(NavigationLink(
                destination: NewFoodView(viewModel: NewFoodViewModel()),
                isActive: $presentNew) {
            })
            .environment(\.defaultMinListRowHeight, 60)
            .navigationBarTitle(Text("Foods"))
            .navigationBarItems(leading:
                HStack {
                    Button("Profile") {
//                        self.presentProfile = true
                    }
                }
            , trailing:
                HStack {
                    EditButton()
                    Button("+") {
                        presentNew = true
                    }
                }
            )
            .onAppear {
                viewModel.setup(foods)
                viewModel.addTestData()
            }
        }
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FoodListView(viewModel: FoodListViewModel())
        }
    }
}
