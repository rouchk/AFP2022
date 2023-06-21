//
//  ContentView.swift
//  Cooking
//
//  Created by apprenant70 on 22/06/2022.
//

import SwiftUI

struct ContentView: View {
    //@EnvironmentObject var appState: AppState
    @State var isLoading = false
    
    var body: some View {
        ZStack {
            TabView {
                MenuRecipes()
                    //.id(appState.rootViewId)
                    .tabItem {
                        Image(systemName: "menucard")
                        Text("Au Menu")
                    }
                
                ListRecipesView()
                    //.id(appState.rootViewId)
                    .tabItem {
                        Image(systemName: "books.vertical")
                        Text("Recettes")
                    }
                
                ProfilView(profil: profilCurrent)
                    //.id(appState.rootViewId)
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profil")
                    }
            }
            
            if isLoading {
                ZStack {
                    Color(.white)
                        .ignoresSafeArea()
                    LogoView()
                }
            }
            
        }
        .onAppear {
            
            loaderBegin()
        }
    }
    
    func loaderBegin() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isLoading = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
