//
//  TestModel.swift
//  Cooking
//
//  Created by apprenant70 on 28/06/2022.
//

import SwiftUI

let persistenceController = PersistenceController.shared


struct TestModel: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TestModel_Previews: PreviewProvider {
    static var previews: some View {
        TestModel()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)

    }
}
