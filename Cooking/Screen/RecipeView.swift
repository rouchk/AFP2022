//
//  RecipeView.swift
//  Cooking
//
//  Created by apprenant70 on 22/06/2022.
//
import ScrollViewReactiveHeader

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe
    var typeRoot: TypeRoot
    
    var fourColumnsGrid = [GridItem(.fixed(80)),
                           GridItem(.fixed(80)),
                           GridItem(.fixed(80)),
                           GridItem(.fixed(80))]
    
    @State private var isShowingSheet = false
    @State private var isContinueAllergens = false
    @State private var isIngredients = true
    @State private var isUtensils = false
    @State private var isAllergens = false
    
    var body: some View {
        
        ScrollViewReactiveHeader(header: {
            
            recipe.getImageRecipe()
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 400)
                .clipped()
            
            
        }, headerOverlay: {
            
        }, body: {
            
            ZStack {
                
                ZStack {
                    Button(action: {
                        isShowingSheet = true
                    }, label: {
                        ZStack {
                            Image("star1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                            Text(String(recipe.score.allAverage()))
                                .font(.title3)
                                .bold()
                                .foregroundColor(.black)
                        }
                        .sheet(isPresented: $isShowingSheet, content: {
                            NoteDetails(recipe: recipe, isShowingSheet: $isShowingSheet)
                        })
                    })
                }
                .frame(width:50, height:50)
                .position(x: 350, y:-370)
                
                /* Affichage du favoris : coeur plein / coeur vide */
                ZStack {
                    RecipeFavorite(recipe: recipe, profil: profilCurrent, isFavorite: profilCurrent.isRecipeFavorite(recipe: recipe))
                        .frame(width:100, height:100)
                        .position(x: 40, y:-370)
                }
                
                VStack {
                    
                    /* Première hstack : coût, difficulté, temps */
                    HStack {
                        
                        /* coût */
                        VStack {
                            Image(systemName: "eurosign.circle")
                                .font(.title2)
                                .foregroundColor(.yellow)
                            Text("\(String(recipe.cost)) €")
                                .font(.system(size: 15))
                        }
                        .padding(.trailing, 60)
                        
                        /* difficulté */
                        VStack {
                            ImageDifficulty(difficulty: recipe.difficulty)
                                .font(.title2)
                                .foregroundColor(.yellow)
                            Text(textDifficulty(difficulty: recipe.difficulty))
                                .font(.system(size: 15))
                        }
                        .frame(width: 100)
                        .padding(.trailing, 60)
                        
                        /* temps de réalisation */
                        VStack {
                            Image(systemName: "clock")
                                .font(.title2)
                                .foregroundColor(.yellow)
                            Text(String(recipe.timeTotal()) + " min")
                                .font(.system(size: 15))
                        }
                    }
                    .padding(.top, 10)
                    
                    
                    /* Titre de la recette */
                    Text(recipe.title)
                        .font(.title3)
                        .bold()
                        .padding(.top, 10)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .multilineTextAlignment(.center)
                    
                    /* Auteur de la recette avec un lien vers son profil */
                    if (recipe.author !== profilCurrent) {
                        NavigationLink(destination: ProfilView(profil: recipe.author)) {
                            Text("par " + recipe.author.name)
                                .italic()
                        }
                    } else {
                        Text("par moi même")
                            .italic()
                    }
                    
                    /* Deuxième hstack : genre, régime, chaud/froid */
                    HStack {
                        /* type de recette*/
                        ZStack {
                            Rectangle()
                                .foregroundColor(.gray)
                                .cornerRadius(7)
                                .shadow(radius: 10)
                            Text(recipe.typeRecipe.rawValue)
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 5)
                        
                        /* régime alimentaire */
                        ZStack {
                            Rectangle()
                                .foregroundColor(.gray)
                                .cornerRadius(7)
                                .shadow(radius: 10)
                            Text(recipe.diet.rawValue)
                                .foregroundColor(.white)
                        }
                        
                        /* nbr de personnes pour le plat */
                        ZStack {
                            Rectangle()
                                .foregroundColor(.gray)
                                .cornerRadius(7)
                                .shadow(radius: 10)
                            Text(String(recipe.nbrPersons) + " personnes")
                                .foregroundColor(.white)
                        }
                        
                        /* chaud ou froid pour le plat */
                        ZStack {
                            Rectangle()
                                .foregroundColor(.gray)
                                .cornerRadius(7)
                                .shadow(radius: 10)
                            HStack {
                                Text(recipe.textHeat())
                                    .foregroundColor(.white)
                                ImageHeat(heat: recipe.heat)
                            }
                            
                        }
                        .padding(.trailing, 5)
                    }
                    .font(.caption)
                    .frame(height: 20)
                    
                    /* Description de la recette */
                    Text(recipe.descr)
                        .font(.caption)
                        .padding()
                    
                    Divider()
                        .background(.red)
                        .frame(height: 20)
                        .frame(width: 150)
                    
                    HStack {
                        if (recipe.ingredients.count > 0) {
                            Button {
                                isIngredients = true
                                isUtensils = false
                                isAllergens = false
                            } label: {
                                Text("Ingredients")
                                    .bold()
                                    .padding(.trailing, 20)
                                    .foregroundColor(isIngredients ? Color("jaune") : .red)
                                
                            }
                        }
                        
                        if (recipe.utensils.count > 0) {
                            Button {
                                isIngredients = false
                                isUtensils = true
                                isAllergens = false
                            } label: {
                                Text("Ustensiles")
                                    .bold()
                                    .padding(.trailing, 20)
                                    .foregroundColor(isUtensils ? Color("jaune") : .red)
                            }
                        }
                        
                        if recipe.isAllergen() {
                            Button {
                                isIngredients = false
                                isUtensils = false
                                isAllergens = true
                            } label: {
                                Text("Allergènes")
                                    .bold()
                                    .foregroundColor(isAllergens ? Color("jaune") : .red)
                            }
                        }
                    }
                    .font(.caption)
                    
                    Divider()
                        .background(.red)
                        .frame(height: 20)
                        .frame(width: 150)
                    
                    if isIngredients {
                        LazyVGrid(columns: fourColumnsGrid, alignment: .center) {
                            ForEach(recipe.ingredients) { element in
                                LabelIngredient(ingredient: element)
                            }
                            
                        }
                        .font(.system(size: 15))
                        .padding()
                    } else if isUtensils {
                        LazyVGrid(columns: fourColumnsGrid, alignment: .center) {
                            ForEach(recipe.utensils) { element in
                                LabelUtensil(utensil: element)
                            }
                        }
                        .font(.system(size: 15))
                    } else if isAllergens {
                        LazyVGrid(columns: fourColumnsGrid, alignment: .center) {
                            ForEach(recipe.allergens) { element in
                                if element.checked {
                                    LabelAllergen(allergen: element)
                                }
                            }
                        }
                        .font(.system(size: 15))
                    }
                    
                    
                    /* Commencer la recette étape par étape */
                    if recipe.steps.count > 0 {
                        Divider()
                            .background(.red)
                            .frame(height: 20)
                            .frame(width: 150)
                        
                        let isAll = profilCurrent.isAllergensInRecipe(recipe: recipe)
                        if isAll {
                            VStack(alignment: .center) {
                                Text("Vous êtes allergique à certains ingrédients de la recette.")
                                    .padding(.top, 10)
                                Toggle("Voulez-vous quand même poursuivre ?", isOn: $isContinueAllergens)
                                    .padding(.bottom, 10)
                                
                            }
                            .font(.caption)
                            .padding()
                            .frame(width: 250)
                            
                        }
                        
                        if isContinueAllergens || !isAll {
                            NavigationLink(destination: RecipeStepByStep(recipe: recipe, typeRoot: typeRoot, step: 0)) {
                                ZStack {
                                    Rectangle()
                                        .cornerRadius(15)
                                        .foregroundColor(.red)
                                        .frame(width: 360, height: 60)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(.black, lineWidth: 2))
                                    Text("Commencer la recette \nétape par étape")
                                        .bold()
                                        .foregroundColor(.black)
                                        .font(.system(size: 15))
                                }
                                .font(.title2)
                                .padding()
                                
                            }
                        } else {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(15)
                                    .foregroundColor(.red)
                                    .frame(width: 360, height: 60)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.black, lineWidth: 2))
                                Text("Commencer la recette \nétape par étape")
                                    .bold()
                                    .foregroundColor(.black)
                                    .font(.system(size: 15))
                            }
                            .font(.title2)
                            .padding()
                            .opacity(0.1)
                        }
                        
                    }
                }
            }
        }, configuration: .init(showStatusBar: true, backgroundColor: .white))
        
            .navigationTitle(recipe.title)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                recipe.popularity += 1
            })
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe(title: "Bouchées de saumon et mangue à la Thaï",
                                  date: Date.now,
                                  author: listProfils.insertProfil(name: "Jean-Marc",
                                                                   xp: 5,
                                                                   utensilsAvailable: [
                                                                    listUtensils.insertUtensil(name: "Couteau", icon: "", amount: 1),
                                                                    listUtensils.insertUtensil(name: "Saladier", icon: "", amount: 1),
                                                                    listUtensils.insertUtensil(name: "Four", icon: "", amount: 1)
                                                                   ]),
                                  descr: "Lorem ipsum dolor sit amet. Et veritatis autem qui fugiat dicta et aliquid molestiae non quasi libero id possimus illo sed nobis aspernatur. Assumenda asperiores non modi esse qui inventore omnis eum rerum recusandae. Eos quis maiores qui incidunt repellendus rem fugit voluptas qui quas amet cum quae alias sit libero nam tenetur cupiditate.",
                                  difficulty: 1,
                                  timeCook: 5,
                                  timePrep: 5,
                                  cost: 16,
                                  nbrPersons: 4,
                                  photo: "bouchee_saumon",
                                  movie: "movie2",
                                  ingredients: [
                                    listIngredients.insertIngredient(name: "échines de porc", icon: "x.squareroot", amountType: .gramm, amount: 200),
                                    listIngredients.insertIngredient(name: "escalopes de poulet", icon: "plusminus", amountType: .none, amount: 2),
                                    listIngredients.insertIngredient(name: "jarret de veau", icon: "plus.circle", amountType: .gramm, amount: 200),
                                    listIngredients.insertIngredient(name: "gousses d'ail", icon: "plus.circle", amountType: .none, amount: 3),
                                    listIngredients.insertIngredient(name: "carottes", icon: "plus.circle", amountType: .none, amount: 2)],
                                  utensils: [
                                    listUtensils.insertUtensil(name: "Couteau", icon: "scissors", amount: 1),
                                    listUtensils.insertUtensil(name: "Saladier", icon: "", amount: 1),
                                    listUtensils.insertUtensil(name: "Four", icon: "", amount: 1)],
                                  diet: .meat,
                                  allergens: [Allergen(allergen: .nut, checked: true),
                                              Allergen(allergen: .crustacean, checked: false),
                                              Allergen(allergen: .celery, checked: false),
                                              Allergen(allergen: .egg, checked: false),
                                              Allergen(allergen: .fish, checked: false),
                                              Allergen(allergen: .gluten, checked: false),
                                              Allergen(allergen: .lupin, checked: false),
                                              Allergen(allergen: .milk, checked: true),
                                              Allergen(allergen: .mollusc, checked: true),
                                              Allergen(allergen: .mustard, checked: false),
                                              Allergen(allergen: .peanut, checked: false),
                                              Allergen(allergen: .sesame, checked: false),
                                              Allergen(allergen: .soja, checked: false),
                                              Allergen(allergen: .so2, checked: false)],
                                  favorite: false,
                                  like: 4,
                                  score: Score(time: [2], amount: [2], explication: [2], result: [2]),
                                  heat: true,
                                  steps: [],
                                  typeRecipe: .main), typeRoot: .profil)
    }
}
