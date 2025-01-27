//
//  LoginView.swift
//  GenesisApp
//
//  Created by Productivity on 7/13/20.
//  Copyright © 2020 Genesis. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var typedPassword = ""
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var userInfo : UserData
    
    @State var showAlert = false
    @State var alertMessage = "Something went wrong. "
    @State var loading = false
    
    var db = Firestore.firestore()
    
    @Binding var showLogIn : Bool
    
    func loggingIn(completion:@escaping((String?) -> () )) {
        loading = true
        session.signIn(email: self.userInfo.email, password: typedPassword) { (result, error) in
        if error != nil {
            
            self.showAlert = true
            self.alertMessage = (error?.localizedDescription ?? "Something went wrong. ")
        } else {
            self.showAlert = false
            
            let docRef = self.db.collection("users").document((result?.user.uid)!)
            docRef.getDocument { (document, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    
                } else {
                    
                    self.userInfo.uid = document?.get("uid") as! String
                    self.userInfo.firstName = document?.get("firstName") as! String
                    self.userInfo.lastName = document?.get("lastName") as! String
                    self.userInfo.email = document?.get("email") as! String
                    
                    self.userInfo.ageRange = document?.get("ageRange") as? String ?? "Unknown"
                    self.userInfo.firstTime = document?.get("firstTime") as? Bool ?? true
                    let rc = document?.get("recentContent") as? [String] ?? []
                    let sa = document?.get("starredContent") as? [String] ?? []
                    self.userInfo.recentContent = document?.get("recentContent") as? [String] ?? []
                    self.userInfo.starredContent = document?.get("starredContent") as? [String] ?? []
                    self.userInfo.moneyWeek = document?.get("moneyWeek") as? Int ?? 0
                    
                    self.userInfo.recentContentMod = []
                    for str in rc {
                        let subarr = str.components(separatedBy: ",")
                        let recview = recentlyViewed(maintopic: subarr[0], title: subarr[1])
                        self.userInfo.recentContentMod.append(recview)
                    }
                    
                    self.userInfo.starredContentMod = []
                    for str in sa {
                        let subarr = str.components(separatedBy: ",")
                        let recview = StarredArtifact(type: subarr[0], maintopic: subarr[1], title: subarr[2])
                        self.userInfo.starredContentMod.append(recview)
                    }
                    
                    withAnimation {
                        self.loading = false
                    }
                    completion(self.userInfo.uid)
                }
            }
                
        }
    }
}
    
    var body: some View {
        LoadingView(isShowing: self.$loading) {
            VStack {
                    
                    HStack {
                        Text("Log In")
                        .font(Font.custom("Lato-Bold", size: 32))
                         
                        Spacer()
                    }
                        .padding(.horizontal,32)
                        .padding(.vertical)
                    
                    
                    
                    VStack {
                        Group {
                            
                            
                            TextField("Email", text: self.$userInfo.email)
                                .signUpTFStyle()
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .disableAutocorrection(true)
                            
                            
                            
                            SecureField("Password", text: self.$typedPassword)
                                .signUpTFStyle()
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                            
                            
                        }
                            .padding(.horizontal)
                            .padding(.vertical,8)
                    }.padding(.bottom,24)
                        

                    Button(action: {
                        self.loggingIn { str in
                            withAnimation {
                                self.viewRouter.currentPage = "contentView"
                            }
                        }
                    }, label: {
                        Text("Log In")
                        .roundedSmallButtonFilledStyle()
                    }).padding(.vertical)
                .alert(isPresented: self.$showAlert) {
                Alert(title: Text("Error "), message:
                        Text(self.alertMessage), dismissButton:
                        .default(Text("OK")))
                }
                    
                    
                    Spacer()
                    Spacer()
                    
                        
                }
                    .offset(y: -30)
                .navigationBarItems(
                leading: Button(action: {
                    self.showLogIn = false
                }, label: {
                    Image("Backward arrow small")
                        .font(.system(size: 24))
                        .foregroundColor(.secondaryText)
                        .padding()
                    
            }))
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showLogIn: .constant(true)).environmentObject(UserData())
    }
}
