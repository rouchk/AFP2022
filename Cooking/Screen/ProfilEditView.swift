import SwiftUI


struct ProfilEditView: View {
    @ObservedObject var profil: Profil
    
    @State var allergens: [Allergen] = []
    @State var nameProfil: String = "Michel"
    @State var photo: String = ""
    @State var photoUI: UIImage = UIImage()
    
    @State var registerPseudo = ""
    @State var sheetAllergen = false
    @State var sheetUtensils = false
    @State var sheetAllergenDel: [Bool] = [false]
    @State var isBack = false
    @State var isClickImage = false
    @State var image = UIImage()
    @State var showSheetAdd = false
    @State var showSheetAdd2 = false
    @State var showSheetAddUste = false
    @State var showSheetAddUste2 = false
    
    @State var fourColumnsGrid = [GridItem(.fixed(80)),
                           GridItem(.fixed(80)),
                           GridItem(.fixed(80)),
                           GridItem(.fixed(80))]
    
    var body: some View {
          //  Form {
                VStack {
                    HStack {
                        profil.getImageProfil()
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100, alignment: .bottom)
                            .clipShape(Circle())
                            .overlay {
                                Circle().stroke(.white, lineWidth: 2)
                            }
                            .onTapGesture {
                                isClickImage = true
                            }
                            .sheet(isPresented: $isClickImage) {
                                // Pick an image from the photo library:
                                ImagePicker(sourceType: .photoLibrary, selectedImage: $profil.photoUI)
                            }
                        
                        TextField("Ton pseudo", text: $profil.name, prompt: Text("Ton pseudo"))
                            .labelsHidden()
                            .font(.system(size: 20))
                            .textFieldStyle(.roundedBorder)
                    }
                    .frame(width:350)
                    
                    Section(header:
                                Text("Modifier mes allergènes")
                                .font(.system(size:25))
                                .bold()
                                .padding(.top)
                    ) {
                        if profil.isAllergic() {
                            LazyVGrid(columns: fourColumnsGrid) {
                                ForEach(self.$profil.allergens) { $el in
                                    if el.checked {
                                        ZStack {
                                            LabelAllergen(allergen: el)
                                            Button {
                                                el.checked = false
                                                profil.updateView()
                                            } label: {
                                                Image(systemName:"xmark.app")
                                                    .foregroundColor(.white)
                                                    .position(x:65, y: 17)
                                                    .font(.title2)
                                            }
                                        }
                                        .frame(width: 80, height: 80)
                                        
                                    }
                                }
                                ZStack {
                                    Rectangle()
                                        .cornerRadius(15)
                                        .foregroundColor(Color("jaune"))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(.black, lineWidth: 2)
                                        )
                                        .frame(width: 80, height: 80)
                                    
                                    Button {
                                        self.showSheetAdd = true
                                    } label: {
                                        Image(systemName:"plus.app")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                    }
                                }
                                .sheet(isPresented: self.$showSheetAdd) {
                                    AddAllergensInProfil(newAllergens: $profil.allergens, showSheetAdd: self.$showSheetAdd)
                                }
                            }
                            .font(.system(size: 15))
                        } else {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(15)
                                    .foregroundColor(Color("jaune"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.black, lineWidth: 2)
                                    )
                                    .frame(width: 80, height: 80)
                                Button {
                                    self.showSheetAdd2 = true
                                } label: {
                                    Image(systemName:"plus.app")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                }
                            }
                            .sheet(isPresented: self.$showSheetAdd2) {
                                AddAllergensInProfil(newAllergens: $profil.allergens, showSheetAdd: self.$showSheetAdd2)
                            }
                        }
                        
                        
                        Section(header:
                                    Text("Modifier mes ustensiles")
                                    .font(.system(size:25))
                                    .bold()
                                    .padding(.top)
                        ) {
                            if !profil.utensilsAvailabe.isEmpty {
                                LazyVGrid(columns: fourColumnsGrid) {
                                    ForEach(0..<$profil.utensilsAvailabe.count, id:\.self) { i in
                                        if profil.utensilsAvailabe[i] != nil && profil.utensilsAvailabe[i].checked {
                                            ZStack {
                                                LabelUtensil(utensil: profil.utensilsAvailabe[i])
                                                Button {
                                                    profil.utensilsAvailabe.remove(at:i)
                                                } label: {
                                                    Image(systemName:"xmark.app")
                                                        .foregroundColor(.white)
                                                        .position(x:65, y: 17)
                                                        .font(.title2)
                                                }
                                            }
                                            .frame(width: 80, height: 80)
                                        }
                                    }
                                    ZStack {
                                        Rectangle()
                                            .cornerRadius(15)
                                            .foregroundColor(Color("jaune"))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(.black, lineWidth: 2)
                                            )
                                            .frame(width: 80, height: 80)
                                        
                                        NavigationLink(destination: AddUtensilsinProfil(utensils: $profil.utensilsAvailabe)) {
                                            Image(systemName:"plus.app")
                                                .foregroundColor(.white)
                                                .font(.title2)
                                        }
                                    }
                                }
                                .font(.system(size: 15))
                            } else {
                                ZStack {
                                    Rectangle()
                                        .cornerRadius(15)
                                        .foregroundColor(Color("jaune"))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(.black, lineWidth: 2)
                                        )
                                        .frame(width: 80, height: 80)
                                    
                                    NavigationLink(destination: AddUtensilsinProfil(utensils: $profil.utensilsAvailabe)) {
                                        Image(systemName:"plus.app")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                    }
                                }
                            }
                        }
//                        Section {
//                            NavigationLink(isActive: $isBack, destination: {
//                                ProfilView(profil: profil)
//                            }, label: { })
//
//                            Button {
//                                isBack = true
//                            } label: {
//                                Text("Valider")
//                            }
//                        }
                    }
                    
                }
           // }
            

        .padding(.bottom, 80.0)
    }
}

//struct ProfilEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        //        ProfilEditView(allergens: .constant([Allergen(allergen: .crustacean)]), nameProfil: .constant("Michel"), photo: .constant(""), photoUI: .constant(UIImage()))
//        //ProfilEditView()
//    }
//}
