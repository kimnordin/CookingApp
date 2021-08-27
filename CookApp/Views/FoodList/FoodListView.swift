//
//  FoodListView.swift
//  CookApp
//
//  Created by Kim Nordin on 2021-08-12.
//

import SwiftUI

struct FoodListView: View {
    @EnvironmentObject var foods: FoodArray
    @State private var presentNew = false
    var body: some View {
        NavigationView {
            List {
                ForEach(foods.list) { food in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination: FoodDetailView(food: food)) {
                        }
                        .opacity(0)
                        FoodListRow(food: food)
                    }
                }
                .onMove(perform: { indices, newOffset in
                    move(indices: indices, newOffset: newOffset)
                })
                .onDelete(perform: { index in
                    delete(at: index)
                })
            }
            .background(NavigationLink(
                destination: NewFoodView(),
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
                addTestData()
            }
        }
    }
    func addTestData() {
        foods.list = testFoodData
    }
    
    func move(indices: IndexSet, newOffset: Int) {
        foods.list.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func delete(at index: IndexSet) {
        for i in index {
            foods.list.remove(at: i)
        }
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FoodListView()
        }
    }
}
