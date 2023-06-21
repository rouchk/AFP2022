//
//  LabelMinimalRecipe.swift
//  Cooking
//
//  Created by apprenant70 on 29/06/2022.
//

import SwiftUI

struct LabelMinimalRecipe: View {
    @ObservedObject var recipe: Recipe
    
    var body: some View {
        VStack {
            Text(recipe.title)
                .font(.caption)
                .frame(width: 110, height:20)
            
            recipe.getImageRecipe()
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 75)
                .clipped()
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("jaune"), lineWidth: 1)
                )
                
        }
    }
}

//struct LabelMinimalRecipe_Previews: PreviewProvider {
//    static var previews: some View {
//        LabelMinimalRecipe()
//    }
//}
