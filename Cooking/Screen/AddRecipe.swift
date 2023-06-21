//
//  addRecipe.swift
//  Cooking
//
//  Created by apprenant70 on 27/06/2022.
//

import PhotosUI
import SwiftUI

struct AddRecipe: View {
    @Environment(\.presentationMode) var presentation
    
    @State var title: String = ""
    var date: Date = Date.now
    @State var descr: String = ""
    @State var difficulty: Int = 0
    @State var timeCook: Int = 0
    @State var timePrep: Int = 0
    @State var cost: Int = 0
    @State var nbrPersons: Int = 0
    @State var typeRecipe: TypeRecipe = .main
    @State var ingredients: [IngredientAmount] = []
    @State var utensils: [UtensilAmount] = []
    @State var step: [StepRecipe] = [StepRecipe(descr: "", img: "")]
    @State var heat: Bool = false
    @State var listAllergenes = [Allergen(allergen: .nut, checked: false),
                                         Allergen(allergen: .crustacean, checked: false),
                                         Allergen(allergen: .celery, checked: false),
                                         Allergen(allergen: .egg, checked: false),
                                         Allergen(allergen: .fish, checked: false),
                                         Allergen(allergen: .gluten, checked: false),
                                         Allergen(allergen: .lupin, checked: false),
                                         Allergen(allergen: .milk, checked: false),
                                         Allergen(allergen: .mollusc, checked: false),
                                         Allergen(allergen: .mustard, checked: false),
                                         Allergen(allergen: .peanut, checked: false),
                                         Allergen(allergen: .sesame, checked: false),
                                         Allergen(allergen: .soja, checked: false),
                                         Allergen(allergen: .so2, checked: false)]
    
    @State var diet: Diet = Diet.meat
    @State var image = UIImage()
    @State var showSheet = false
    @State var showSheetStep: [Bool] = [false]
    @State var isEditingIng = false
    @State var searchIng: String = ""
    @State var isAction = false
    
    var body: some View {
        
        //NavigationView {
            Form {
                Section(header: Text("Général")) {
                    TextField("Nom de la recette", text: $title)
                    TextField("Description de la recette", text: $descr)
                    
                    Picker("Difficulté", selection: $difficulty) {
                        ForEach(0..<4) { index in
                            Text(textDifficulty(difficulty: index))
                                .tag(index)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Picker("Type de repas", selection: $typeRecipe) {
                        ForEach(TypeRecipe.allCases, id:\.self) { type1 in
                            Text(type1.rawValue)
                        }
                    }
                    
                    Toggle(heat ? "Repas chaud" : "Repas froid", isOn: $heat)
                    
                    Picker("Régime alimentaire", selection: $diet) {
                        ForEach(Diet.allCases, id:\.self) { diet1 in
                            Text(diet1.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    NavigationLink {
                        List($listAllergenes) { $all in
                            Toggle(all.allergen.rawValue, isOn: $all.checked)
                        }
                    } label : {
                        Text("Allergènes")
                    }
                    
                    HStack {
                        Text("Ajouter une image de recette")
                            .frame(height: 50)
                            .onTapGesture {
                                showSheet = true
                            }
                        
                        Image(uiImage: self.image)
                            .resizable()
                            .cornerRadius(15)
                            .frame(width: 50, height: 50)
                            .background(Color.black.opacity(0.2))
                            .aspectRatio(contentMode: .fill)
                            .padding(.leading, 70)
                        
                    }
                    .sheet(isPresented: $showSheet) {
                        // Pick an image from the photo library:
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
                }
                
                Section(header: Text("Nombre de personnes")) {
                    TextField("Nombre de personnes", value: $nbrPersons, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Coût (€)")) {
                    TextField("Coût", value: $cost, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Temps de préparation (min)")) {
                    TextField("Temps de préparation", value: $timePrep, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Temps de cuisson (min)")) {
                    TextField("Temps de cuisson", value: $timeCook, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Ingrédients")) {
                    List(0..<ingredients.count, id:\.self) { index in
                        GroupBox {
                            HStack {
                                Text("Ingrédient :")
                                
                                Picker("Ingrédient", selection: self.$ingredients[index].ingredient.name) {
                                    ForEach(listIngredients.listIngredients) { ing in
                                        Text(ing.name)
                                            .tag(ing.name)
                                    }
                                }
                                .background(.white)
                            }
                            
                            
                            HStack {
                                Text("Quantité: ")
                                TextField("Quantité", value: self.$ingredients[index].amount, format: .number)
                                    .keyboardType(.decimalPad)
                                    .background(.white)
                                    .padding()
                                
                                Text("Type de quantité: ")
                                Picker("Type", selection: self.$ingredients[index].amountType) {
                                    ForEach(AmountType.allCases, id:\.self) { amountType in
                                        Text(amountType.rawValue)
                                    }
                                }
                                .background(.white)
                                
                            }
                            
                            if (index == ingredients.count-1) && (index > 0) {
                                Button {
                                    self.ingredients.remove(at:index)
                                } label: {
                                    Image(systemName: "xmark.app")
                                }
                            }
                            
                        }
                        .font(.caption)
                    }
                    
                    Button {
                        self.ingredients.append(IngredientAmount(ingredient: Ingredient(name: "", icon: ""), amountType: .none, amount: 0))
                    } label: {
                        Image(systemName: "plus.app")
                    }
                }
                
                Section(header: Text("Ustensiles")) {
                    List(0..<utensils.count, id:\.self) { index in
                        GroupBox {
                            HStack {
                                Text("Ustensile :")
                                
                                Picker("Ustensile", selection: self.$utensils[index].utensil.name) {
                                    ForEach(listUtensils.listUtensils) { ute in
                                        Text(ute.name)
                                            .tag(ute.name)
                                    }
                                }
                                .background(.white)
                                
                                Text("Quantité: ")
                                TextField("Quantité", value: self.$utensils[index].amount, format: .number)
                                    .keyboardType(.decimalPad)
                                    .background(.white)
                                    .padding()
                            }
                            
                            if (index == utensils.count-1) && (index > 0) {
                                Button {
                                    self.utensils.remove(at:index)
                                } label: {
                                    Image(systemName: "xmark.app")
                                }
                            }
                            
                        }
                        .font(.caption)
                    }
                    
                    Button {
                        self.utensils.append(UtensilAmount(utensil: Utensil(name: "", icon: ""), amount: 0))
                    } label: {
                        Image(systemName: "plus.app")
                    }
                }
                
                Section(header: Text("Étapes")) {
                    List(0..<step.count, id:\.self) { index in
                        GroupBox {
                            HStack {
                                Text("\(String(index+1)) :")
                                
                                TextField("Description", text: self.$step[index].descr)
                                
                                Image(uiImage: self.step[index].imgUI)
                                    .resizable()
                                    .cornerRadius(15)
                                    .frame(width: 50, height: 50)
                                    .background(Color.black.opacity(0.2))
                                    .aspectRatio(contentMode: .fill)
                                    .padding(.leading, 70)
                                    .onTapGesture {
                                        self.showSheetStep[index] = true
                                    }
                                    
                            }
                            .sheet(isPresented: self.$showSheetStep[index]) {
                                // Pick an image from the photo library:
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$step[index].imgUI)
                            }
                            
                            
                            if (index == step.count-1) && (index > 0) {
                                Button {
                                    self.step.remove(at:index)
                                    self.showSheetStep.remove(at:index)
                                } label: {
                                    Image(systemName: "xmark.app")
                                }
                            }
                            
                        }
                        .font(.caption)
                    }
                    
                    Button {
                        self.step.append(StepRecipe(descr: "", img: ""))
                        self.showSheetStep.append(false)
                    } label: {
                        Image(systemName: "plus.app")
                    }
                }
                
   
                Section {
                    NavigationLink(isActive: $isAction, destination: {
                        ListRecipesView()
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(false)
                    }, label: { })
                        .hidden()
                    
                    Button {
                        
                        if (!ingredients.isEmpty)
                        {
                            /* associer les icones des ingredients choisis avec la liste commune des ingrédients */
                            for ing in ingredients {
                                ing.ingredient.icon = listIngredients.searchIconByName(name: ing.ingredient.name)
                            }
                        }
                        
                        if (!utensils.isEmpty) {
                            /* associer les icones des ustensiles choisis avec la liste commune des ustensiles */
                            for ute in utensils {
                                ute.utensil.icon = listUtensils.searchIconByName(name: ute.utensil.name)
                            }
                        }
                        
                        profilCurrent.xp += 200
                        
                        listRecipes.append(Recipe(title: title, date: date, author: profilCurrent, descr: descr, difficulty: difficulty, timeCook: timeCook, timePrep: timePrep, cost: cost, nbrPersons: nbrPersons, photoUI: image, movie: "", ingredients: ingredients, utensils: utensils, diet: diet, allergens: listAllergenes, favorite: false, like: 0, score: Score(), heat: heat, steps: step, typeRecipe: typeRecipe))

                        
                        isAction = true
                    } label: {
                        Text("Valider")
                    }
                }
                
            }
        //}
    }
    
}
