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
    @State var name: String = ""
    @State var uiImage: UIImage? = nil
    @State var alertItem: AlertItem?
    @State var showImagePicker = false
    @State var foodCreated = false
    @State var changeAlert = false
    @State var showAlert = false
    @State var showAction = false
    @State var rating: Int = 0
    @State var selectedIngredient: Ingredient?
    @State var ingredientDescription: String?
    @State var ingredients = [Ingredient]()
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        if (uiImage == nil) {
                            Text("Snap a picture of your food")
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                            Image(systemName: "camera.circle.fill")
                                .resizable()
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    displayImagePicker()
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                        } else {
                            Image(uiImage: uiImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke((colorScheme == .dark ? Color.white : Color.black), lineWidth: 4))
                                .shadow(radius: 10)
                                .padding()
                                .frame(width: geo.size.width)
                                .onTapGesture {
                                    displayActionSheet()
                                }
                        }
                    }
                    VStack {
                        TextField("Give your Dish a name", text: $name)
                            .multilineTextAlignment(.center)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        RatingInputView(rating: $rating)
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
                        if !ingredients.isEmpty {
                            TagView(tags: stringIngredients(), callback: { tag in
                                selectedTag(tag)
                            })
                            .lineLimit(1)
                            .padding()
                        }
                    }
                }
                .fixFlickering()
                .alert(isPresented: $showAlert, AlertConfig(title: "Ingredient", placeholder: "Add an Ingredient", action: {
                    if let string = $0 {
                        addIngredient(string)
                    }
                }))
                .alert(isPresented: $changeAlert, AlertConfig(title: "Change Ingredient", placeholder: selectedIngredient?.description ?? "", action: {
                    if let string = $0 {
                        changeIngredient(string)
                    }
                }))
                .alert(item: $alertItem, content: { alertItem in
                    Alert(title: alertItem.title,
                          message: alertItem.message,
                          dismissButton: .default(alertItem.buttonTitle))
                })
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    dismissImagePicker()
                }, content: {
                    ImagePicker(isShown: $showImagePicker, uiImage: $uiImage)
                })
                .actionSheet(isPresented: $showAction) {
                    sheet
                }
                Group {
                    Button(action: {
                        createFood(name: name, image: uiImage, ingredients: ingredients, rating: rating)
                        if foodCreated {
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
        var strIngredients = [String]()
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
            foods.addFood(food: Food(name: name, image: image, ingredients: ingredients, rating: rating))
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

struct NewFoodView_Previews: PreviewProvider {
    static var previews: some View {
        NewFoodView()
            .environmentObject(FoodArray())
    }
}
