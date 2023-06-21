import SwiftUI

struct ProfilView: View {
    @ObservedObject var profil: Profil
    
    var fourColumnsGrid = [GridItem(.fixed(80)),
                           GridItem(.fixed(80)),
                           GridItem(.fixed(80)),
                           GridItem(.fixed(80))]
    
    var niveauSuivant:Int = 500
    @State var currentProgress: CGFloat = 0.0
    @State var isActive : Bool = false
    @State var isLastRecipes = true
    @State var isMyFavorites = false
    @State var isUtensils = false
    @State var isAllergens = false
    
    func startLoading() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            withAnimation() {
                self.currentProgress += 0.01
                if self.currentProgress >= CGFloat((profil.xp%niveauSuivant))/CGFloat(niveauSuivant) {
                    timer.invalidate()
                }
            }
        }
    }
    
    var array1 = ["Item1", "Item2", "Item3"]
    var array2 = ["Item1", "Item2", "Item3", "Item2", "Item3"]
    var array3 = ["Item1", "Item2", "Item2", "Item3", "Item3"]
    
    @State var tableau: [String] =  ["Item1", "Item2", "Item3"]
    
    var body: some View {
        
        let niveauProfil = Int(round(Double(profil.xp/niveauSuivant)))
        
        NavigationView  {
            
            VStack {
                ZStack {
                    Color(.red)
                        .ignoresSafeArea()
                    
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.white)
                        .frame(height:160)
                        .position(x:200, y:200)
                    
                    HStack {
                        
                        profil.getImageProfil()
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125, alignment: .bottom)
                            .clipShape(Circle())
                            .overlay {
                                Circle().stroke(.white, lineWidth: 2)
                            }
                        
                        VStack {
                            Text(profil.name)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .padding(.trailing, 120.0)
                                .padding(.bottom, 10)
                            
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 250, height: 20)
                                    .foregroundColor(.gray)
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width:250*currentProgress, height: 20)
                                    .foregroundColor(.yellow)
                                    .onAppear {
                                        startLoading()
                                    }
                            }
                            
                            Text("niveau : \(String(niveauProfil+1))")
                                .font(.system(size:15))
                        }
                    }
                    .padding(.top, 50)
                    .padding(20)
                    
                }
                .frame(height: 220)
                
                HStack {
                    if (!profil.recipes.isEmpty) {
                        Button {
                            isLastRecipes = true
                            isMyFavorites = false
                            isUtensils = false
                            isAllergens = false
                        } label: {
                            Text("Dernières\nrecettes")
                                .bold()
                                .padding(.trailing, 20)
                                .foregroundColor(isLastRecipes ? Color("jaune") : .red)
                            
                        }
                    }
                    
                    if (!profil.recipesFavorites.isEmpty) {
                        Button {
                            isLastRecipes = false
                            isMyFavorites = true
                            isUtensils = false
                            isAllergens = false
                        } label: {
                            Text("Mes favoris")
                                .bold()
                                .padding(.trailing, 20)
                                .foregroundColor(isMyFavorites ? Color("jaune") : .red)
                        }
                    }
                    
                    if (!profil.utensilsAvailabe.isEmpty) {
                        Button {
                            isLastRecipes = false
                            isMyFavorites = false
                            isUtensils = true
                            isAllergens = false
                        } label: {
                            Text("Ustensiles")
                                .bold()
                                .foregroundColor(isUtensils ? Color("jaune") : .red)
                        }
                    }
                    
                    if profil.isAllergic() {
                        Button {
                            isLastRecipes = false
                            isMyFavorites = false
                            isUtensils = false
                            isAllergens = true
                        } label: {
                            Text("Allergènes")
                                .bold()
                                .padding(.leading, 20)
                                .foregroundColor(isAllergens ? Color("jaune") : .red)
                        }
                    }
                }
                .font(.caption)
                
                Divider()
                    .background(.red)
                    .frame(height: 50)
                    .frame(width: 150)
                
                if isMyFavorites {
                    List(profil.recipesFavorites.suffix(3).reversed()) { recf in
                        NavigationLink(destination: RecipeView(recipe: recf, typeRoot: .profil))
                        {
                            LabelRecipe(recipe: recf)
                        }
                    }
                } else if isLastRecipes {
                    List(profil.recipes.suffix(3).reversed()) { recf in
                        NavigationLink(destination: RecipeView(recipe: recf, typeRoot: .profil))
                        {
                            LabelRecipe(recipe: recf)
                        }
                    }
                } else if isUtensils {
                    LazyVGrid(columns: fourColumnsGrid) {
                        ForEach(profil.utensilsAvailabe) { element in
                            LabelUtensil(utensil: element)
                        }
                    }
                    .font(.system(size: 15))
                } else if isAllergens {
                    LazyVGrid(columns: fourColumnsGrid) {
                        ForEach(profil.allergens) { element in
                            if element.checked {
                                LabelAllergen(allergen: element)
                            }
                        }
                    }
                    .font(.system(size: 15))
                    
                }
                Spacer()
            }
            .navigationTitle("Profil")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                    NavigationLink {
                        ProfilEditView(profil: profil)
                    } label: {
                        Image(systemName: "gear")
                            .foregroundColor(Color("jaune"))
                    }
                
            )
            .navigationBarHidden((profil !== profilCurrent))
        }
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView(profil: Profil(name: "Macroute", photo: "macroute", xp: 200, utensilsAvailable: []))
        //.previewInterfaceOrientation(.portrait)
    }
}

