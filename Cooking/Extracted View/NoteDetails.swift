//
//  NoteDetails.swift
//  Cooking
//
//  Created by apprenant70 on 27/06/2022.
//

import SwiftUI

struct NoteDetails: View {
    var recipe: Recipe
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        Text("Note détaillée")
            .font(.title)
            .bold()
            .padding()
            .padding(.bottom, 40)
            .foregroundColor(.black)
        
        ViewRanking(param: "Respect du temps", score: recipe.score.oneAverage(one: recipe.score.time))
        
        Divider()
            .padding(.bottom, 20)
        
        ViewRanking(param: "Respect des quantités", score: recipe.score.oneAverage(one: recipe.score.amount))
        
        Divider()
            .padding(.bottom, 20)
        
        ViewRanking(param:  "Qualité des explications", score: recipe.score.oneAverage(one: recipe.score.explication))
        
        Divider()
            .padding(.bottom, 20)
        
        ViewRanking(param:  "Résultat attendu", score: recipe.score.oneAverage(one: recipe.score.result))
        
        Divider()
            .padding(.bottom, 20)
        
        Button(action: {
            isShowingSheet = false
        }, label: {
            Text("Fermer")
                .font(.title)
                .foregroundColor(.black)
                .padding()
        })
    }
}

struct NoteDetails_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetails(recipe: Recipe(title: "Bouchées de saumon et mangue à la Thaï",
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
                                   typeRecipe: .main), isShowingSheet: .constant(false))
    }
}
