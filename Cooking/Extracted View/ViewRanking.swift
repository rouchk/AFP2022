//
//  ViewRanking.swift
//  Cooking
//
//  Created by apprenant70 on 27/06/2022.
//

import SwiftUI

struct ViewRanking: View {
    var param: String
    var score: Int
    
    var body: some View {
        VStack {
            Text(param)
                .font(.title2)
                .foregroundColor(.black)
            Divider()
                .padding(.top, 0)
                
            HStack {
                ForEach(0..<5) { i in
                    Image(systemName: i < score ? "star.fill" : "star")
                }
            }
        }
    }
}

struct ViewRanking_Previews: PreviewProvider {
    static var previews: some View {
        ViewRanking(param: "Test", score: 1)
    }
}
