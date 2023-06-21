//
//  ImageMainRecipeView.swift
//  Cooking
//
//  Created by apprenant70 on 30/06/2022.
//

import SwiftUI

func getImageRecipe(recipe: Recipe) -> Image {
    
    if (recipe.photoUI != UIImage()) {
        return Image(uiImage: recipe.photoUI)
        
    } else if (recipe.photo != "") {
        return Image(recipe.photo)
        
    }
    return Image("imageVide")
}

func getImageStep(step: StepRecipe) -> Image {
    if (step.imgUI != UIImage()) {
        return Image(uiImage: step.imgUI)
        
    } else if (step.img != "") {
        return Image(step.img)
        
    }
    return Image("imageVide")
}

struct ImageMainRecipeView: View {
    var recipe: Recipe
    
    
    var body: some View {
       
        /* Image fixe de la recette */
       
        getImage(recipe: recipe)
            .resizable()
            .background(Color.black.opacity(0.5))
            .aspectRatio(contentMode: .fill)
            .frame(height: 400)
    
        
        
    }
}
//
//struct ImageMainRecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageMainRecipeView()
//    }
//}
