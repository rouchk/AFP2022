//
//  LabelRecipe.swift
//  Cooking
//
//  Created by apprenant70 on 29/06/2022.
//

import SwiftUI

struct LabelRecipe: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            
            recipe.getImageRecipe()
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 100)
                    .clipped()
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color("jaune"), lineWidth: 1)
                    )
            
            Divider()
                .background(.red)
                .frame(height: 90)
                .frame(width: 10)
            
            VStack {
                HStack {
                    Text(recipe.title)
                        .font(.system(size:14))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                }
                
                if (recipe.author !== profilCurrent) {
                    Text(String("par " + recipe.author.name))
                }
                HStack {
                    if (recipe.cost > 0) {
                        Text(String(recipe.cost) + "€")
                    }
                   
                    if (recipe.cost > 0) && (recipe.timeTotal() > 0) {
                        Text(" / ")
                    }
                    
                    
                    if (recipe.timeTotal() > 0) {
                        Text(String(recipe.timeTotal()) + "min")
                    }
                    
                }
                .padding(.top, 0.5)
                .padding(.bottom)
                
                HStack {
                    ImageDifficulty(difficulty: recipe.difficulty)
                        .foregroundColor(Color("jaune"))
                    
                    
                    ImageHeat(heat: recipe.heat)
                        .font(.system(size: 15))
                }
            }
            .font(.caption)
            .frame(width: 125, height: 100)
        }
    }
}
//
//struct LabelRecipe_Previews: PreviewProvider {
//    static var previews: some View {
//        LabelRecipe()
//    }
//}
