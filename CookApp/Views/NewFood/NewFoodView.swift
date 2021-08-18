//
//  NewFoodView.swift
//  CookApp
//
//  Created by Kim Nordin on 2021-08-13.
//

import SwiftUI

struct NewFoodView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var foods: FoodArray
    @ObservedObject var viewModel = NewFoodViewModel()
    @State var showAlert = false
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        if (viewModel.uiImage == nil) {
                            Text("Snap a picture of your food")
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                            Image(systemName: "camera.circle.fill")
                                .resizable()
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    viewModel.displayImagePicker()
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                        } else {
                            Image(uiImage: viewModel.uiImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke((colorScheme == .dark ? Color.white : Color.black), lineWidth: 4))
                                .shadow(radius: 10)
                                .padding()
                                .frame(width: geo.size.width)
                                .onTapGesture {
                                    viewModel.displayActionSheet()
                                }
                        }
                    }
                    VStack {
                        TextField("Give your Dish a name", text: $viewModel.name)
                            .multilineTextAlignment(.center)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        RatingInputView(rating: $viewModel.rating)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        HStack {
                            Text("Ingredients")
                                .font(.headline)
                            Button("+") {
                                showAlert = true
                            }
                            .accentColor(colorScheme == .dark ? Color.white : Color.black)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                        if !viewModel.ingredients.isEmpty {
                            TagView(tags: viewModel.stringIngredients(), callback: { tag in
                                viewModel.selectedTag(tag)
                            })
                            .lineLimit(1)
                            .padding()
                        }
                    }
                }
                .fixFlickering()
                .onAppear {
                    viewModel.setup(foods)
                }
                .alert(isPresented: $showAlert, AlertConfig(title: "Ingredient", placeholder: "Add an Ingredient", action: {
                    if let string = $0 {
                        viewModel.addIngredient(string)
                    }
                }))
                .alert(isPresented: $viewModel.changeAlert, AlertConfig(title: "Change Ingredient", placeholder: viewModel.selectedIngredient?.description ?? "", action: {
                    if let string = $0 {
                        viewModel.changeIngredient(string)
                    }
                }))
                .alert(item: $viewModel.alertItem, content: { alertItem in
                    Alert(title: alertItem.title,
                          message: alertItem.message,
                          dismissButton: .default(alertItem.buttonTitle))
                })
                .sheet(isPresented: $viewModel.showImagePicker, onDismiss: {
                    viewModel.dismissImagePicker()
                }, content: {
                    ImagePicker(isShown: $viewModel.showImagePicker, uiImage: $viewModel.uiImage)
                })
                .actionSheet(isPresented: $viewModel.showAction) {
                    viewModel.sheet
                }
                Group {
                    Button(action: {
                        viewModel.createFood(name: viewModel.name, image: viewModel.uiImage, ingredients: viewModel.ingredients, rating: viewModel.rating)
                        if viewModel.foodCreated {
                            self.presentation.wrappedValue.dismiss()
                        }
                    }, label: {
                        Text("Add Food")
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    })
                    .frame(width: 120, height: 55)
                    .padding(.horizontal, 8).lineLimit(1).minimumScaleFactor(0.4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 4)
                    )
                }
            }
        }
    }
}

struct NewFoodView_Previews: PreviewProvider {
    static var previews: some View {
        NewFoodView(viewModel: NewFoodViewModel())
        .environmentObject(FoodArray())
    }
}
