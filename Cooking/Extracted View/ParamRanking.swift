//
//  ParamRanking.swift
//  Cooking
//
//  Created by apprenant70 on 24/06/2022.
//

import SwiftUI

struct ParamRanking: View {
    var param: String
    @Binding var score: Int
    @State private var isStar = [false, false, false, false, false]
    
    func setRanking(i: Int) {
        for index in 0...i {
            isStar[index] = true
        }
    }
    
    func unsetRanking(i: Int) {
        for index in i...4 {
            isStar[index] = false
        }
    }
    
    var body: some View {
        VStack {
            Text(param)
                .font(.title2)
            Divider()
                .padding(.top, 0)

            HStack {
                ForEach(0..<5) { i in
                    Button {
                        if isStar[i] {
                            //score.assignTypeScore(typeScore: typeScore, score:i)
                            self.score = i
                            unsetRanking(i: i)
                        } else {
                            //score.assignTypeScore(typeScore: typeScore, score:i+1)
                            self.score = i+1
                            setRanking(i: i)
                        }
                        
                    } label: {
                        Image(systemName: isStar[i] ? "star.fill" : "star")
                    }
                    
                }
                
            }
            .font(.title)
        }
    }
}

struct ParamRanking_Previews: PreviewProvider {
    
    static var previews: some View {
        ParamRanking(param: "Respect du temps", score: .constant(0))
    }
}
