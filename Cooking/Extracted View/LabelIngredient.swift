//
//  LabelIngredient.swift
//  Cooking
//
//  Created by apprenant70 on 29/06/2022.
//

import SwiftUI

struct LabelIngredient: View {
    var ingredient: IngredientAmount
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .cornerRadius(15)
                .foregroundColor(Color("jaune"))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.black, lineWidth: 2)
                )
            
            VStack(alignment: .center) {
                if ingredient.amount == round(ingredient.amount) {
                    Text(String(Int(ingredient.amount)) + " " + ingredient.amountType.rawValue)
                        .font(.system(size: 10))
                        .bold()
                } else {
                    Text(String(ingredient.amount) + " " + ingredient.amountType.rawValue)
                        .font(.system(size: 10))
                        .bold()
                }
                Text(ingredient.ingredient.name)
                    .bold()
                    .font(.system(size: 10))
                    .multilineTextAlignment(.center)
                    .frame(width: 60)
                    .padding(.bottom, 7)
                if (!ingredient.ingredient.icon.isEmpty) {
                    Image(ingredient.ingredient.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 7)
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                }
            }
            .frame(width: 80, height: 80)
            
        }
    }
}
//
//struct LabelIngredient_Previews: PreviewProvider {
//    static var previews: some View {
//        LabelIngredient()
//    }
//}
