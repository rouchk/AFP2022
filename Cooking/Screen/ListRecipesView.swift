//
//  ListRecipeView.swift
//  Cooking
//
//  Created by Apprenant44 on 22/06/2022.
//

import SwiftUI
import AudioToolbox

struct ListRecipesView: View {
    @State var isActiveAdd : Bool = true
    @State var isActiveList : Bool = true
    @State private var searchRecipe = ""
    @State var filtreIngActive = 0
    @State private var listIngredientsActive = listIngredients.listIngredients
    @State private var isShowingSheetFilter = false
    @State var isShowingSheetAdd = false
    @State private var isDifficulty = false
    @State private var isIngredients = false
    @State private var isCost = false
    @State private var isAllergens = false
    @State private var isType = false
    @State private var isTime = false
    @State private var isNbrPersons = false
    @State private var title = ""
    @State private var descr = ""
    @State private var difficulty = 0
    @State private var cost = 0
    @State private var timeCook = 0
    @State private var timePrep = 0
    @State private var time = 0
    @State private var type = TypeRecipe.main
    @State private var nbrPersons = 0
    @State private var diet = Diet.meat
    
    func reinitialiseIngredient() {
        for ing in listIngredientsActive {
            ing.active = false
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
            
                /* Affichage du filtre actif */
                if isIngredients && (filtreIngActive > 0) {
                    HStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.gray)
                            HStack {
                                Text("Filtre ingrédients")
                                
                                Button {
                                    reinitialiseIngredient()
                                    isIngredients = false
                                    filtreIngActive = 0
                                } label: {
                                    Image(systemName: "xmark.app")
                                }
                            }
                            .font(.title3)
                        }
                        .padding()
                    }
                    .frame(height:30)
                } else if isDifficulty {
                    FiltreView(isFilter: $isDifficulty, nameFilter: "difficulté")
                        .opacity(0.7)
                } else if isCost {
                    FiltreView(isFilter: $isCost, nameFilter: "coût")
                } else if isAllergens {
                    FiltreView(isFilter: $isAllergens, nameFilter: "allergènes")
                } else if isType {
                    FiltreView(isFilter: $isType, nameFilter: "type")
                } else if isTime {
                    FiltreView(isFilter: $isTime, nameFilter: "temps")
                } else if isNbrPersons {
                    FiltreView(isFilter: $isNbrPersons, nameFilter: "nombre de personnes")
                }
                
                /* Affichage de la liste de recettes */
                if searchResult.isEmpty {
                    List {
                        Text("Aucune recette")
                    }
                } else {
                    List(searchResult.reversed()) { rec1 in
                        NavigationLink(destination: RecipeView(recipe: rec1, typeRoot: .listRecipes))
                        {
                            LabelRecipe(recipe: rec1)
                        }
                    }
                }
            }
            .navigationTitle("Liste des recettes")
            .navigationBarTitleDisplayMode(.inline)
           
            .searchable(text: $searchRecipe, placement: .navigationBarDrawer(displayMode: .always), prompt: "Nom de la recette")
            
            /* écran d'ajout d'une recette */
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: AddRecipe())  {
                        Image(systemName: "plus.circle")
                    }
            )
            
            /* modal de la liste des filtres */
            .navigationBarItems(
                leading:
                    Button(action : {
                        isShowingSheetFilter = true
                    }, label: {
                        Image(systemName: "slider.horizontal.3")
                    })
                    .sheet(isPresented: $isShowingSheetFilter, content: {
                        FormFiltersRecipes(searchRecipe: $searchRecipe, filtreIngActive: $filtreIngActive, listIngredientsActive: $listIngredientsActive, isShowingSheet: $isShowingSheetFilter, isDifficulty: $isDifficulty, isIngredients: $isIngredients, isCost: $isCost, isAllergens: $isAllergens, isType: $isType, isTime: $isTime, isNbrPersons: $isNbrPersons, title: $title, descr: $descr, difficulty: $difficulty, cost: $cost, time: $time, type: $type, nbrPersons: $nbrPersons, diet: $diet)
                        
                    })
            )
            
        }
    }
    
    func searchIngredient(recipe: Recipe) -> Bool {
        var pos = 0

        for element in listIngredientsActive {
            if element.active {
                for elementFil in recipe.ingredients {
                    if (element === elementFil.ingredient) {
                        pos += 1
                    }
                }
            }
        }
        
        return pos == filtreIngActive
    }
    
    var searchResult: [Recipe] {
        
            if isIngredients && (filtreIngActive != 0) {
                return listRecipes.filter { recipe in
                    searchRecipe.isEmpty ? searchIngredient(recipe: recipe) : searchIngredient(recipe: recipe) && recipe.title.lowercased().contains(searchRecipe.lowercased())
                }
            } else if isDifficulty {
                return listRecipes.filter { recipe in
                    searchRecipe.isEmpty ? recipe.difficulty == difficulty : (recipe.difficulty == difficulty) && recipe.title.lowercased().contains(searchRecipe.lowercased())
                }
            } else if isCost {
                return listRecipes.filter { recipe in
                    searchRecipe.isEmpty ? recipe.cost < cost : (recipe.cost < cost) && recipe.title.lowercased().contains(searchRecipe.lowercased())
                }
            } else if isAllergens {
                return listRecipes.filter { recipe in
                    searchRecipe.isEmpty ? !profilCurrent.isAllergensInRecipe(recipe: recipe) : !profilCurrent.isAllergensInRecipe(recipe: recipe) && recipe.title.lowercased().contains(searchRecipe.lowercased())
                }
            } else if isTime {
                return listRecipes.filter { recipe in
                    searchRecipe.isEmpty ? recipe.timeTotal() < time : (recipe.timeTotal() < time) && recipe.title.lowercased().contains(searchRecipe.lowercased())
                }
            } else if isType {
                return listRecipes.filter { recipe in
                    searchRecipe.isEmpty ? recipe.typeRecipe == type : (recipe.typeRecipe == type) && recipe.title.lowercased().contains(searchRecipe.lowercased())
                }
            } else if isNbrPersons {
                return listRecipes.filter { recipe in
                    searchRecipe.isEmpty ? recipe.nbrPersons <= nbrPersons : (recipe.nbrPersons <= nbrPersons) && recipe.title.lowercased().contains(searchRecipe.lowercased())
                }
            } else if !searchRecipe.isEmpty {
                return listRecipes.filter { recipe in recipe.title.lowercased().contains(searchRecipe.lowercased())
                }
            }
     
        return listRecipes
        
    }
   
}

struct ListRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        ListRecipesView()
    }
}
