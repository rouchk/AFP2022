//
//  RecipeFavorite.swift
//  Cooking
//
//  Created by apprenant70 on 28/06/2022.
//

import SwiftUI

struct RecipeFavorite: View {
    @StateObject var recipe: Recipe
    @StateObject var profil: Profil
    @State var isFavorite: Bool

    var body: some View {
        Button {
            isFavorite.toggle()
            if (isFavorite) {
                profil.recipesFavorites.append(recipe)
            } else {
                var i = 0
                var isFav = false
                for fav in profil.recipesFavorites {
                    if fav === recipe {
                        isFav = true
                        break
                    }
                    i += 1
                }
                if isFav {
                    profil.recipesFavorites.remove(at: i)
                }
            }
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.red)
                .frame(width: 45, height: 45, alignment: .center)
        }
    }
}

struct RecipeFavorite_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFavorite(recipe: Recipe(title: "Bouchées de saumon et mangue à la Thaï",
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
                                      typeRecipe: .main),
                       profil: profilCurrent, isFavorite: false)
    }
}

