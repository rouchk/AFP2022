//
//  RecipeStepByStep.swift
//  Cooking
//
//  Created by apprenant70 on 24/06/2022.
//

import SwiftUI

struct RecipeStepByStep: View {
    var recipe: Recipe
    var typeRoot: TypeRoot
    @State var step: Int = 0
    
    var body: some View {
        let stepRecipe = recipe.steps[step]
        let stepsTotal = recipe.steps.count
        
        VStack {
            stepRecipe.getImageStep()
            
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            
                    .frame(width: 250, height: 250)
                    .border(Color.black, width: 3)
                    .clipped()
           
            HStack {
                Text("\(String(step+1)).")
                    .font(.system(size: 40))
                    .bold()
                Text(stepRecipe.descr)
            }
            .frame(width: 250)
            
            HStack {
                if (step > 0) {
                    Button {
                        step -= 1
                    } label: {
                        ZStack(alignment: .trailing) {
                            Rectangle()
                                .foregroundColor(Color("jaune"))
                                .cornerRadius(15)
                            Image(systemName: "arrow.left.circle")
                                .foregroundColor(.white)
                        }
                        .font(.title)
                        .frame(width:30, height:30)
                    }
                }
                
                Spacer()
                
                if (step+1 < stepsTotal) {
                    Button {
                        step += 1
                    } label: {
                        ZStack(alignment: .trailing) {
                            Rectangle()
                                .foregroundColor(Color("jaune"))
                                .cornerRadius(15)
                            Image(systemName: "arrow.right.circle")
                                .foregroundColor(.white)
                        }
                        .font(.title)
                        .frame(width:30, height:30)
                    }
                    
                } else if (step+1 == stepsTotal) {
                    NavigationLink(destination: EndRecipeNotation(recipe: recipe, typeRoot: typeRoot)) {
                        ZStack(alignment: .trailing) {
                            Rectangle()
                                .foregroundColor(Color("jaune"))
                                .cornerRadius(15)
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.white)
                        }
                        .font(.title)
                        .frame(width:30, height:30)
                    }
                }
            }
            .frame(width: 300)
            
        }
        .navigationTitle(recipe.title + " \(String(step+1))/\(String(stepsTotal))")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct RecipeStepByStep_Previews: PreviewProvider {
    static var previews: some View {
        RecipeStepByStep(recipe:
                            Recipe(title: "Bouchées de saumon et mangue à la Thaï",
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
                                   steps: [StepRecipe(descr: "Détachez la chair du lapin. Coupez en morceaux l'échine de porc désossée, les escalopes de poulet et le jarret de veau.", img: "step1"),
                                           StepRecipe(descr: "Pelez les gousses d'ail, les couper en 2 puis retirez le germe. Coupez le céléri en petits morceaux.", img: "step2"),
                                           StepRecipe(descr: "Dans un saladier, mélangez l'ail, le céléri, le thym, le laurier, les baies de genièvre et de poivre. Versez y les morceaux de viande, mélangez et couvrez avec la bière brune du Nord. Laissez mariner pendant 24 heures en remuant environ toutes les 6 heures.", img: "step3")],
                                   typeRecipe: .main), typeRoot: .profil)
    }
}
