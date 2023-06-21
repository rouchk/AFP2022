//
//  AddAllergensInProfil.swift
//  Cooking
//
//  Created by apprenant70 on 01/07/2022.
//

import SwiftUI

struct AddAllergensInProfil: View {
    
    @Binding var newAllergens: [Allergen]
    @Binding var showSheetAdd: Bool
    
    var body: some View {
        Form {
            Section {
                List($newAllergens) { $all in
                    Toggle(all.allergen.rawValue, isOn: $all.checked)
                }
            }
            
            Button {
                showSheetAdd = false
            } label: {
                Text("Valider")
            }
        }
    }
}
//
//struct AddAllergensInProfil_Previews: PreviewProvider {
//    static var previews: some View {
//        AddAllergensInProfil()
//    }
//}
