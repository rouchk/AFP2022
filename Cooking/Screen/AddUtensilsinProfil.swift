//
//  AddUtensilsinProfil.swift
//  Cooking
//
//  Created by apprenant70 on 01/07/2022.
//

import SwiftUI

struct AddUtensilsinProfil: View {
    @Environment(\.presentationMode) var presentation
    @Binding var utensils: [UtensilAmount]
    @State var nameUtensil = ""
    @State var amount = 0
    
    var body: some View {
        
        Form {
            Section {
                Picker("Ustensile", selection: $nameUtensil) {
                    ForEach(listUtensils.listUtensils) { ute in
                        Text(ute.name)
                            .tag(ute.name)
                    }
                    .background(.white)
                }
            }
            Section {
                Text("Quantité: ")
                TextField("Quantité", value: self.$amount, format: .number)
                    .keyboardType(.decimalPad)
                    .background(.white)
                    .padding()
            }
            Button {
                var isAlready = false
                for ut in self.utensils {
                    if ut.utensil.name == self.nameUtensil {
                        ut.amount += self.amount
                        isAlready = true
                        break
                    }
                }
                
                if !isAlready {
                    self.utensils.append(UtensilAmount(utensil: Utensil(name: nameUtensil, icon: listUtensils.searchIconByName(name: nameUtensil)), checked: true, amount: amount))
                }
                presentation.wrappedValue.dismiss()
            } label: {
                Text("Valider")
            }

        }
    }
}

//struct AddUtensilsinProfil_Previews: PreviewProvider {
//    static var previews: some View {
//        AddUtensilsinProfil()
//    }
//}
