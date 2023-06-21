//
//  LabelAllergen.swift
//  Cooking
//
//  Created by apprenant70 on 29/06/2022.
//

import SwiftUI

struct LabelAllergen: View {
    var allergen: Allergen
    
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
                Text(allergen.allergen.rawValue)
                    .bold()
                    .font(.system(size: 10))
                    .multilineTextAlignment(.center)
                    .frame(width: 60)
                    .padding(.bottom, 7)
                if (!allergen.icon.isEmpty) {
                    Image(allergen.icon)
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
//struct LabelAllergen_Previews: PreviewProvider {
//    static var previews: some View {
//        LabelAllergen()
//    }
//}
