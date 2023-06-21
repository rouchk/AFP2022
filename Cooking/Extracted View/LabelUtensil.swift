//
//  LabelUtensil.swift
//  Cooking
//
//  Created by apprenant70 on 29/06/2022.
//

import SwiftUI

struct LabelUtensil: View {
    var utensil: UtensilAmount
    
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
                if (utensil.amount > 1) {
                    Text(String(utensil.amount))
                        .font(.system(size: 10))
                        .bold()
                }
                Text(utensil.utensil.name)
                    .bold()
                    .font(.system(size: 10))
                    .multilineTextAlignment(.center)
                    .frame(width: 60)
                    .padding(.bottom, 7)
                if (!utensil.utensil.icon.isEmpty) {
                    Image(utensil.utensil.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 7)
                        .font(.system(size: 10))
                }
            }
            
        }
        .frame(width: 80, height: 80)
    }
}
//
//struct LabelUtensil_Previews: PreviewProvider {
//    static var previews: some View {
//        LabelUtensil()
//    }
//}
