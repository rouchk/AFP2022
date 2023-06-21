//
//  MenuRecipes.swift
//  Cooking
//
//  Created by apprenant70 on 28/06/2022.
//

import SwiftUI

struct MenuRecipes: View {
    @State var isActive : Bool = false
    @State var sortRecipe: [Recipe] = listRecipes
    @State var mostNotedRecipes: [Recipe] = listRecipes
    
    var body: some View {
        NavigationView {
            VStack {

                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color("jaune"))
                    
                    VStack {
                        Section(header:
                                    Text("Recette du jour")
                                    .font(.system(size:25))
                                    .bold()) {
                            HStack {
                                let recipe = listRecipes[Int.random(in:0..<listRecipes.count)]
                                
                                NavigationLink(destination: RecipeView(recipe: recipe, typeRoot: .menuRecipes))
                                {
                                    LabelRecipe(recipe: recipe)
                                }
                            }
                        }
                    }
                    .padding()
                    .background()
                }
                .frame(width: 350, height:180)
                
                Divider()
                    .background(.red)
                    .frame(height: 50)
                    .frame(width: 150)
                
                Section(header:
                            Text("Recettes les plus populaires :")
                            .font(.system(size:20))
                            .bold()) {
                    HStack {
                        ForEach(sortRecipe.prefix(3)) { recipe in
                            NavigationLink(destination: RecipeView(recipe: recipe, typeRoot: .menuRecipes))
                            {
                                LabelMinimalRecipe(recipe: recipe)
                            }
                        }
                    }
                }
                
                Divider()
                    .background(.red)
                    .frame(height: 50)
                    .frame(width: 150)
                
                Section(header:
                            Text("Recettes les mieux notées :")
                            .font(.system(size:20))
                            .bold()) {
                    HStack {
                        ForEach(mostNotedRecipes.prefix(3)) { recipe in
                            NavigationLink(destination: RecipeView(recipe: recipe, typeRoot: .menuRecipes))
                            {
                                LabelMinimalRecipe(recipe: recipe)
                            }
                        }
                    }
                    
                }
                
                Spacer()
                
            }
            .onAppear{
                sortRecipe = listRecipes.sorted {
                   $0.popularity > $1.popularity
               }
                
                mostNotedRecipes = listRecipes.sorted {
                    $0.score.allAverage() > $1.score.allAverage()
                }
            }
            
            .navigationTitle("Au Menu")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MenuRecipes_Previews: PreviewProvider {
    static var previews: some View {
        MenuRecipes()
    }
}
