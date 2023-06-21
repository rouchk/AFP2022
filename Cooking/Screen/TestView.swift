//
//  TestView.swift
//  Cooking
//
//  Created by apprenant70 on 30/06/2022.
//

import SwiftUI

struct TestView: View {
    @State var allergens: [Allergen]
    
    var fourColumnsGrid = [GridItem(.fixed(80)),
                           GridItem(.fixed(80)),
                           GridItem(.fixed(80)),
                           GridItem(.fixed(80))]
    
    var body: some View {
        NavigationView {
            VStack {
                
                if !allergens.isEmpty {
                    VStack {
                        List(0..<allergens.count, id:\.self) { i in
                            if allergens[i].checked {
                                ZStack {
                                    LabelAllergen(allergen: allergens[i])
                                    Button {
                                        allergens[i].checked = false
                                        print(allergens[i].checked)
                                        print(i)
                                    } label: {
                                        Image(systemName:"xmark.app")
                                            .foregroundColor(.white)
                                        //.position(x:65, y: 17)
                                            .font(.title2)
                                        //                                                    .onTapGesture {
                                        //                                                        profil.allergens[i].checked = false
                                        //                                                    }
                                    }
                                }
                                .frame(width: 80, height: 80)
                                
                            }
                        }
                    }
                }
            }
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(allergens: [
                            Allergen(allergen:.crustacean, checked: true),
                            Allergen(allergen:.celery, checked: true)
                           ])
    }
}
