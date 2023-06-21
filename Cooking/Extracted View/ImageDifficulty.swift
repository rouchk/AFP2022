//
//  ImageDifficulty.swift
//  Cooking
//
//  Created by apprenant70 on 23/06/2022.
//

import SwiftUI

struct ImageDifficulty: View {
    var difficulty: Int
    
    var body: some View {
        HStack {
            switch difficulty {
            case 0:
                Image(systemName: "fork.knife.circle")
                Image(systemName: "fork.knife.circle")
                Image(systemName: "fork.knife.circle")
            case 1:
                Image(systemName: "fork.knife.circle.fill")
                Image(systemName: "fork.knife.circle")
                Image(systemName: "fork.knife.circle")
            case 2:
                Image(systemName: "fork.knife.circle.fill")
                Image(systemName: "fork.knife.circle.fill")
                Image(systemName: "fork.knife.circle")
                
            default:
                Image(systemName: "fork.knife.circle.fill")
                Image(systemName: "fork.knife.circle.fill")
                Image(systemName: "fork.knife.circle.fill")
            }
        }
    }
}

struct ImageDifficulty_Previews: PreviewProvider {
    static var previews: some View {
        ImageDifficulty(difficulty: 0)
    }
}
