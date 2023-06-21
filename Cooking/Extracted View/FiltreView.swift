//
//  FiltreView.swift
//  Cooking
//
//  Created by apprenant70 on 30/06/2022.
//

import SwiftUI

struct FiltreView: View {
    @Binding var isFilter: Bool
    @State var nameFilter: String
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                HStack {
                    Text("Filtre \(nameFilter)")
                    
                    Button {
                        isFilter = false
                    } label: {
                        Image(systemName: "xmark.app")
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
        }
        .frame(height:35)
    }
}

struct FiltreView_Previews: PreviewProvider {
    static var previews: some View {
        FiltreView(isFilter: .constant(true), nameFilter: "Bonjour")
    }
}
