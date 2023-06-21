//
//  Models.swift
//  Cooking
//
//  Created by apprenant70 on 22/06/2022.
//

import Foundation
import CoreLocation
import UIKit
import SwiftUI

/*
    INGREDIENT
 */
enum AmountType: String, CaseIterable {
    case gramm = "g"
    case liter = "l"
    case mliter = "ml"
    case cliter = "cl"
    case cc = "c.c"
    case cs = "c.s"
    case pincee = "pincée"
    case none = ""
}

class Ingredient: Identifiable, ObservableObject {
    var id = UUID()
    @Published var name: String
    @Published var icon: String
    @Published var active: Bool
    
    init(name: String, icon: String, active: Bool = false) {
        self.name = name
        self.icon = icon
        self.active = active
    }
}

class IngredientAmount: Identifiable, ObservableObject {
    var id = UUID()
    @Published var ingredient: Ingredient
    @Published var amountType: AmountType
    @Published var amount: Double
    
    init(ingredient: Ingredient, amountType: AmountType, amount: Double) {
        self.ingredient = ingredient
        self.amountType = amountType
        self.amount = amount
    }
    
}

class Ingredients: Identifiable, ObservableObject {
    @Published var listIngredients: [Ingredient]
    
    init(listIngredients: [Ingredient] = []) {
        self.listIngredients = listIngredients
    }
    
    func insertIngredient(name: String, icon: String, amountType: AmountType, amount: Double) -> IngredientAmount {
        var isHere = false
        var id2 = 0
        let ing = Ingredient(name: name, icon: icon)
        
        for ing in listIngredients {
            if ing.name == name {
                isHere = true
                break
            }
            id2 += 1
        }
        
        if !isHere {
            self.listIngredients.append(ing)
        }
        
        return IngredientAmount(ingredient: ing, amountType: amountType, amount: Double(amount))
    }
    
    func searchIngredientId(name: String) -> Int {
        var id2 = 0
        var isHere = false
        
        for ing in listIngredients {
            if ing.name == name {
                isHere = true
                break
            }
            id2 += 1
        }
        
        if isHere {
            return id2
        } else {
            return -1
        }
    }
    
    func getIngredient(ingredientId: Int) -> Ingredient {
        return listIngredients[ingredientId]
    }
    
    
    func searchIconByName(name: String) -> String {
        for ing in listIngredients {
            if ing.name == name {
                return ing.icon
            }
        }
        return ""
    }
}

/*
    UTENSIL
 */
class Utensil: Identifiable, ObservableObject {
    @Published var id = UUID()
    @Published var name: String
    @Published var icon: String
    
    init(name: String, icon: String) {
        self.name = name
        self.icon = icon
    }
}

class UtensilAmount: Identifiable, ObservableObject {
    @Published var id = UUID()
    @Published var utensil: Utensil
    @Published var checked: Bool
    @Published var amount: Int
    
    init (utensil: Utensil, checked: Bool = true, amount: Int = 0) {
        self.utensil = utensil
        self.checked = checked
        self.amount = amount
    }
    
    func updateView() {
        self.objectWillChange.send()
    }
}

class Utensils: Identifiable, ObservableObject {
    @Published var listUtensils: [Utensil]
    
    init(listUtensils: [Utensil] = []) {
        self.listUtensils = listUtensils
    }
    
    func insertUtensil(name: String, icon: String, amount: Int) -> UtensilAmount {
        var isHere = false
        var id2 = 0
        let ust = Utensil(name: name, icon: icon)
        
        for ing in listUtensils {
            if ing.name == name {
                isHere = true
                break
            }
            id2 += 1
        }
        
        if !isHere {
            self.listUtensils.append(ust)
        }
        
        return UtensilAmount(utensil: ust, amount: amount)
    }
    
    func searchUtensilbyName(name: String) -> Bool {
        var isHere = false
        
        for ing in listUtensils {
            if ing.name == name {
                return true
            }
        }
        
        return false
    }
    
    func searchIconByName(name: String) -> String {
        for ute in listUtensils {
            if ute.name == name {
                return ute.icon
            }
        }
        return ""
    }
    
}

/*
    SCORE
 */
class Score: Identifiable, ObservableObject {
    var id = UUID()
    
    @Published var time: [Int]
    @Published var amount: [Int]
    @Published var explication: [Int]
    @Published var result: [Int]
    
    init(time: [Int] = [], amount: [Int] = [], explication: [Int] = [], result: [Int] = []) {
        self.time = time
        self.amount = amount
        self.explication = explication
        self.result = result
    }
    
    func oneAverage(one: [Int]) -> Int {
        var somme = 0
        
        if (one.count > 0) {
            for el in one {
                somme += el
            }
        
            return somme / one.count
        } else {
            return somme
        }
    }
    
    func allAverage () -> Int {
        return (oneAverage(one: self.time) + oneAverage(one: self.amount) + oneAverage(one: self.explication) + oneAverage(one: self.result)) / 4
    }
}

/*
    RECIPE
 */
enum Allergens: String, CaseIterable {
    case gluten = "Gluten"
    case crustacean = "Crustacé"
    case egg = "Oeuf"
    case fish = "Poisson"
    case peanut = "Arachide"
    case soja = "Soja"
    case milk = "Lait"
    case nut = "Fruits à coque"
    case celery = "Céleri"
    case mustard = "Moutarde"
    case sesame = "Sésame"
    case lupin = "Lupin"
    case mollusc = "Mollusque"
    case so2 = "Anhydride sulfureux"
}

class Allergen : Identifiable, ObservableObject {
    @Published var id = UUID()
    @Published var allergen: Allergens
    @Published var icon: String = ""
    @Published var checked: Bool = true
    
    init(allergen: Allergens, icon: String = "", checked: Bool = true) {
        self.allergen = allergen
        switch(allergen) {
        case .gluten:
            self.icon = "gluten"
        case .crustacean:
            self.icon = "crustace"
        case .egg:
            self.icon = "oeuf"
        case .fish:
            self.icon = "poisson"
        case .peanut:
            self.icon = "cacahuete"
        case .soja:
            self.icon = "soja"
        case .milk:
            self.icon = "lait"
        case .nut:
            self.icon = "nut"
        case .celery:
            self.icon = "celery"
        case .mustard:
            self.icon = "mustard"
        case .sesame:
            self.icon = "sesame"
        case .lupin:
            self.icon = "lupin"
        case .mollusc:
            self.icon = "mollusc"
        case .so2:
            self.icon = ""
        }
        self.checked = checked
    }
}

enum Diet: String, CaseIterable {
    case vegan = "Végétalien"
    case veggie = "Végétarien"
    case meat = "Carné"
}

enum TypeRecipe: String, CaseIterable {
    case soup = "Soupe"
    case salad = "Salade"
    case dessert = "Dessert"
    case tart = "Tarte"
    case fastfood = "FastFood"
    case main = "Plat classique"
}

struct StepRecipe: Identifiable {
    var id = UUID()
    var descr: String
    var img: String = ""
    var imgUI: UIImage = UIImage()
    
    func getImageStep() -> Image {
        if (self.imgUI != UIImage()) {
            return Image(uiImage: self.imgUI)
            
        } else if (self.img != "") {
            return Image(self.img)
            
        }
        return Image("imageVide")
    }
}

func textDifficulty(difficulty: Int) -> String {
    switch difficulty {
    case 0:
        return "Très facile"
    case 1:
        return "Facile"
    case 2:
        return "Intermédiaire"
    default:
        return "Difficile"
    }
}

class Recipe: Identifiable, ObservableObject {
    var id = UUID()
    var title: String
    var date: Date
    var author: Profil
    var descr: String
    var difficulty: Int
    var timeCook: Int
    var timePrep: Int
    var cost: Int
    var nbrPersons: Int
    var photo: String
    var photoUI: UIImage
    var movie: String
    var ingredients: [IngredientAmount]
    var utensils: [UtensilAmount]
    var diet: Diet
    @Published var allergens: [Allergen]
    var favorite: Bool
    var like: Int
    @Published var score: Score
    var heat: Bool
    var steps: [StepRecipe]
    var typeRecipe: TypeRecipe
    @Published var popularity: Int

    init(title: String, date: Date, author: Profil, descr: String, difficulty: Int, timeCook: Int, timePrep: Int, cost: Int, nbrPersons: Int, photo: String = "", photoUI: UIImage = UIImage(), movie: String, ingredients: [IngredientAmount], utensils: [UtensilAmount], diet: Diet, allergens: [Allergen] = [Allergen(allergen: .nut, checked: false),
                                                                                                                                                                                                                                                                                                                Allergen(allergen: .crustacean, checked: false),
                                                                                                                                                                                                                                                                                                                Allergen(allergen: .celery, checked: false),
                                                                                                                                                                                                                                                                                                                Allergen(allergen: .egg, checked: false),
                                                                                                                                                                                                                                                                                                                Allergen(allergen: .fish, checked: false),
                                                                                                                                                                                                                                                                                                                Allergen(allergen: .gluten, checked: false),
                                                                                                                                                                                                                                                                                                                Allergen(allergen: .lupin, checked: false),
                                                                                                                                                                                                                                                                                                                Allergen(allergen: .milk, checked: false),
                                                                                                                                                                                                                                                                                                                Allergen(allergen: .mollusc, checked: false),
                                                                                                                                                                                                                                                                                                                Allergen(allergen: .mustard, checked: false),
                                                                                                                                                                                                                                                                                                                Allergen(allergen: .peanut, checked: false),
                                                                                                                                                                                                                                                                                                                Allergen(allergen: .sesame, checked: false),
                                                                                                                                                                                                                                                                                                                Allergen(allergen: .soja, checked: false),
                                                                                                                                                                                                                                                                                                                Allergen(allergen: .so2, checked: false)], favorite: Bool, like: Int, score: Score, heat: Bool, steps: [StepRecipe], typeRecipe: TypeRecipe, popularity: Int = 0) {
        self.title = title
        self.date = date
        self.author = author
        self.descr = descr
        self.difficulty = difficulty
        self.timeCook = timeCook
        self.timePrep = timePrep
        self.cost = cost
        self.nbrPersons = nbrPersons
        self.photo = photo
        self.photoUI = photoUI
        self.movie = movie
        self.ingredients = ingredients
        self.utensils = utensils
        self.diet = diet
        self.allergens = allergens
        self.favorite = favorite
        self.like = like
        self.score = score
        self.heat = heat
        self.steps = steps
        self.typeRecipe = typeRecipe
        self.popularity = popularity
        self.author.recipes.append(self)
    }
    
    func difficultyToExp() -> Int {
        return (self.difficulty + 1)*50
    }
    
    func textHeat() -> String {
        return self.heat ? "Chaud" : "Froid"
    }
    
    func timeTotal() -> Int {
        return timeCook + timePrep
    }
    
    func increasePopularity() {
        self.popularity += 1
    }
    
    func getImageRecipe() -> Image {
        if (self.photoUI != UIImage()) {
            return Image(uiImage: self.photoUI)
            
        } else if (self.photo != "") {
            return Image(self.photo)
            
        }
        return Image("imageVide")
    }
    
    func isAllergen() -> Bool {
        for all in self.allergens {
            if all.checked {
                return true
            }
        }
        return false
    }
    
    
    func updateView() {
        self.objectWillChange.send()
    }
}

/*
    PROFIL
 */
class Profil: Identifiable, ObservableObject {
    var id = UUID()
    @Published var name: String
    @Published var photo: String
    @Published var photoUI: UIImage
    @Published var xp: Int
    @Published var utensilsAvailabe: [UtensilAmount]
    @Published var recipes: [Recipe]
    @Published var recipesFavorites: [Recipe]
    @Published var allergens: [Allergen]
    
    init(name: String, photo: String = "", photoUI: UIImage = UIImage(), xp: Int = 0, utensilsAvailable: [UtensilAmount] = [], allergens: [Allergen] = [Allergen(allergen: .nut, checked: false),
                                                                                                                                                        Allergen(allergen: .crustacean, checked: false),
                                                                                                                                                        Allergen(allergen: .celery, checked: false),
                                                                                                                                                        Allergen(allergen: .egg, checked: false),
                                                                                                                                                        Allergen(allergen: .fish, checked: false),
                                                                                                                                                        Allergen(allergen: .gluten, checked: false),
                                                                                                                                                        Allergen(allergen: .lupin, checked: false),
                                                                                                                                                        Allergen(allergen: .milk, checked: false),
                                                                                                                                                        Allergen(allergen: .mollusc, checked: false),
                                                                                                                                                        Allergen(allergen: .mustard, checked: false),
                                                                                                                                                        Allergen(allergen: .peanut, checked: false),
                                                                                                                                                        Allergen(allergen: .sesame, checked: false),
                                                                                                                                                        Allergen(allergen: .soja, checked: false),
                                                                                                                                                        Allergen(allergen: .so2, checked: false)], recipes: [Recipe] = [], recipesFavorites: [Recipe] = []) {
        self.name = name
        self.photo = photo
        self.photoUI = photoUI
        self.xp = xp
        self.recipes = recipes
        self.utensilsAvailabe = utensilsAvailable
        self.recipesFavorites = recipesFavorites
        self.allergens = allergens
    }
    
    func isRecipeFavorite(recipe: Recipe) -> Bool {
        var isFav = false
        
        for rec in self.recipesFavorites {
            if (rec === recipe) {
                isFav = true
                break
            }
        }
        return isFav
    }

    func isAllergensInRecipe(recipe: Recipe) -> Bool {
        for el in self.allergens {
            for el2 in recipe.allergens {
                if (el.allergen == el2.allergen) && (el.checked && el2.checked) {
                    return true
                }
            }
        }
       
        return false
    }
    
    
    func isAllergic() -> Bool {
        for all in self.allergens {
            if all.checked {
                return true
            }
        }
        return false
    }
    
    func getImageProfil() -> Image {
        if (self.photoUI != UIImage()) {
            return Image(uiImage: self.photoUI)
            
        } else if (self.photo != "") {
            return Image(self.photo)
            
        }
        return Image("imageNoProfil")
    }
    
    func updateView() {
        self.objectWillChange.send()
    }
}

class Profils: Identifiable, ObservableObject {
    @Published var listProfils: [Profil]
    
    init(listProfils: [Profil] = []) {
        self.listProfils = listProfils
    }
    
    func insertProfil(name: String, photo: String = "", xp: Int = 0, utensilsAvailable: [UtensilAmount] = [], recipes: [Recipe] = [], allergens: [Allergen] = []) -> Profil {
        var isHere = false
        var id2 = 0
        
        for ing in listProfils {
            if ing.name == name {
                isHere = true
                break
            }
            id2 += 1
        }
        
        if !isHere {
            let profil = Profil(name: name, photo: photo, xp: xp, utensilsAvailable: utensilsAvailable, allergens: allergens, recipes: recipes)
            
            self.listProfils.append(profil)
            return profil
        } else {
            return listProfils[id2]
        }
    }
    
    func getProfil(id: Int) -> Profil {
        return self.listProfils[0]
    }
    
}

enum TypeRoot {
    case menuRecipes, listRecipes, profil
}

final class AppState: ObservableObject {
    @Published var rootViewId = UUID()
}
