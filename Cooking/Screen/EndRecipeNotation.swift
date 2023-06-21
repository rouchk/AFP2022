//
//  EndRecipeNotation.swift
//  Cooking
//
//  Created by apprenant70 on 24/06/2022.
//

import SwiftUI

struct EndRecipeNotation: View {
    @StateObject var recipe: Recipe
    var typeRoot: TypeRoot
    @State var scoreTime = 0
    @State var scoreAmount = 0
    @State var scoreExplication = 0
    @State var scoreResult = 0
    @State var isActionMenu = false
    @State var isActionProfil = false
    @State var isActionList = false
    
    var body: some View {
        
        VStack {
            
            VStack{
                
                Text("C’est terminé !\n Qu’est-ce que vous en avez pensé ?")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
                
                ParamRanking(param: "Respect du temps", score: $scoreTime)
                
                Divider()
                    .padding(.bottom, 20)
                
                ParamRanking(param: "Respect des quantités", score: $scoreAmount)
                
                Divider()
                    .padding(.bottom, 20)
                
                ParamRanking(param: "Qualité des explications", score: $scoreExplication)
                
                Divider()
                    .padding(.bottom, 20)
                
                ParamRanking(param: "Résultat attendu", score: $scoreResult)
                
                Divider()
                    .padding(.bottom, 20)
            }
            
            NavigationLink(isActive: $isActionList) {
                ListRecipesView()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            } label: {
            }
            
            NavigationLink(isActive: $isActionMenu) {
                MenuRecipes()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            } label: {
            }
            
            NavigationLink(isActive: $isActionProfil) {
                ProfilView(profil: profilCurrent)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            } label: {
            }
            
            Button("Valider") {
                recipe.score.time.append(scoreTime)
                recipe.score.amount.append(scoreAmount)
                recipe.score.explication.append(scoreExplication)
                recipe.score.result.append(scoreResult)
                profilCurrent.xp += recipe.difficultyToExp()
                switch(typeRoot) {
                case .profil:
                    isActionMenu = false
                    isActionList = false
                    isActionProfil = true
                case .listRecipes:
                    isActionMenu = false
                    isActionProfil = false
                    isActionList = true
                case .menuRecipes:
                    isActionProfil = false
                    isActionList = false
                    isActionMenu = true
                }
            }
            .font(.title)
            .padding()
            
        }
        .frame(width: 300)
        .navigationTitle("Noter la recette")
    }
}

struct EndRecipeNotation_Previews: PreviewProvider {
    static var previews: some View {
        EndRecipeNotation(recipe: Recipe(title: "Bouchées de saumon et mangue à la Thaï",
                                         date: Date.now,
                                         author: listProfils.insertProfil(name: "Jean-Marc",
                                                                          xp: 5,
                                                                          utensilsAvailable: [
                                                                            listUtensils.insertUtensil(name: "Couteau", icon: "", amount: 1),
                                                                            listUtensils.insertUtensil(name: "Saladier", icon: "", amount: 1),
                                                                            listUtensils.insertUtensil(name: "Four", icon: "", amount: 1)
                                                                          ]),
                                         descr: "Lorem ipsum dolor sit amet. Et veritatis autem qui fugiat dicta et aliquid molestiae non quasi libero id possimus illo sed nobis aspernatur. Assumenda asperiores non modi esse qui inventore omnis eum rerum recusandae. Eos quis maiores qui incidunt repellendus rem fugit voluptas qui quas amet cum quae alias sit libero nam tenetur cupiditate.",
                                         difficulty: 1,
                                         timeCook: 5,
                                         timePrep: 5,
                                         cost: 16,
                                         nbrPersons: 4,
                                         photo: "bouchee_saumon",
                                         movie: "movie2",
                                         ingredients: [
                                            listIngredients.insertIngredient(name: "échines de porc", icon: "x.squareroot", amountType: .gramm, amount: 200),
                                            listIngredients.insertIngredient(name: "escalopes de poulet", icon: "plusminus", amountType: .none, amount: 2),
                                            listIngredients.insertIngredient(name: "jarret de veau", icon: "plus.circle", amountType: .gramm, amount: 200),
                                            listIngredients.insertIngredient(name: "gousses d'ail", icon: "plus.circle", amountType: .none, amount: 3),
                                            listIngredients.insertIngredient(name: "carottes", icon: "plus.circle", amountType: .none, amount: 2)],
                                         utensils: [
                                            listUtensils.insertUtensil(name: "Couteau", icon: "scissors", amount: 1),
                                            listUtensils.insertUtensil(name: "Saladier", icon: "", amount: 1),
                                            listUtensils.insertUtensil(name: "Four", icon: "", amount: 1)],
                                         diet: .meat,
                                         allergens: [],
                                         favorite: false,
                                         like: 4,
                                         score: Score(time: [2], amount: [2], explication: [2], result: [2]),
                                         heat: true,
                                         steps: [],
                                         typeRecipe: .main), typeRoot: .profil)
    }
}
