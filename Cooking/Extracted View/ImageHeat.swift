//
//  ImageHeat.swift
//  Cooking
//
//  Created by apprenant70 on 23/06/2022.
//

import SwiftUI

struct ImageHeat: View {
    var heat: Bool
    
    var body: some View {
        if heat {
            Image(systemName:"flame.circle")
                .foregroundColor(.red)
        } else {
            Image(systemName:"snowflake.circle")
                .foregroundColor(.blue)
        }
    }
}

struct ImageHeat_Previews: PreviewProvider {
    static var previews: some View {
        ImageHeat(heat: true)
    }
}
