//
//  FormFiltersRecipes.swift
//  Cooking
//
//  Created by apprenant70 on 30/06/2022.
//

import SwiftUI

struct FormFiltersRecipes: View {
    @Binding var searchRecipe: String
    @Binding var filtreIngActive: Int
    @Binding var listIngredientsActive: [Ingredient]
    @Binding var isShowingSheet: Bool
    @Binding var isDifficulty: Bool
    @Binding var isIngredients: Bool
    @Binding var isCost: Bool
    @Binding var isAllergens: Bool
    @Binding var isType: Bool
    @Binding var isTime: Bool
    @Binding var isNbrPersons: Bool
    @Binding var title: String
    @Binding var descr: String
    @Binding var difficulty: Int
    @Binding var cost: Int
    @Binding var time: Int
    @Binding var type: TypeRecipe
    @Binding var nbrPersons: Int
    @Binding var diet: Diet
    
    var body: some View {
        Form {
            List {
                Section(header: Text("Filtrer par")) {
                    VStack {
                        if !isIngredients && !isCost && !isAllergens && !isTime && !isType && !isNbrPersons {
                            Toggle("Difficulté", isOn: $isDifficulty)
                            
                            if isDifficulty {
                                Picker("Difficulté", selection: $difficulty) {
                                    ForEach(0..<4) { index in
                                        Text(textDifficulty(difficulty: index))
                                            .tag(index)
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                        } else {
                            Text("Difficulté")
                        }
                    }
                    
                    VStack {
                        if !isDifficulty && !isCost && !isAllergens && !isTime && !isType && !isNbrPersons {
                            Toggle("Ingrédients", isOn: $isIngredients)
                            
                            if isIngredients {
                                List($listIngredientsActive) { $all in
                                    Toggle(all.name, isOn: $all.active)
                                }
                            }
                        } else {
                            Text("Ingrédients")
                        }
                        
                    }
                    
                    VStack {
                        if !isDifficulty && !isCost && !isIngredients && !isTime && !isType && !isNbrPersons {
                            Toggle("Mes allergènes", isOn: $isAllergens)
                        } else {
                            Text("Mes allergènes")
                        }
                        
                    }
                    
                    VStack {
                        if !isDifficulty && !isIngredients && !isAllergens && !isTime && !isType && !isNbrPersons {
                            Toggle("Coût inférieur à", isOn: $isCost)
                            
                            if isCost {
                                TextField("en euros", value: $cost, format: .number)
                                    .keyboardType(.decimalPad)
                            }
                        } else {
                            Text("Coût inférieur à")
                        }
                        
                    }
                    
                    VStack {
                        if !isDifficulty && !isIngredients && !isAllergens && !isCost && !isType && !isNbrPersons {
                            Toggle("Temps inférieur à", isOn: $isTime)
                            
                            if isTime {
                                TextField("en min", value: $time, format: .number)
                                    .keyboardType(.decimalPad)
                            }
                        } else {
                            Text("Temps inférieur à")
                        }
                    }
                    
                    VStack {
                        if !isDifficulty && !isIngredients && !isAllergens && !isCost && !isType && !isTime {
                            Toggle("Nombre de personnes au max", isOn: $isNbrPersons)
                            
                            if isNbrPersons {
                                TextField("nombre de personnes", value: $nbrPersons, format: .number)
                                    .keyboardType(.decimalPad)
                            }
                        } else {
                            Text("Nombre de personnes au max")
                        }
                        
                    }
                    
                    VStack {
                        if !isDifficulty && !isIngredients && !isAllergens && !isTime && !isCost && !isNbrPersons {
                            Toggle("Type", isOn: $isType)
                            
                            if isType {
                                Picker("Type", selection: $type) {
                                    ForEach(TypeRecipe.allCases, id:\.self) { index in
                                        Text(index.rawValue)
                                            .tag(index)
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                        } else {
                            Text("Type")
                        }
                        
                    }
                    
                }
            }
            
            Button(action: {
                if isIngredients {
                    filtreIngActive = 0
                    for all in listIngredientsActive {
                        if all.active {
                            filtreIngActive += 1
                        }
                    }
                }
                isShowingSheet = false
            }, label: {
                Text("Valider")
            })
        }
    }
}
//
//struct FormFiltersRecipes_Previews: PreviewProvider {
//    static var previews: some View {
//        FormFiltersRecipes()
//    }
//}
