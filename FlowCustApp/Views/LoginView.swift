//
//  LoginView.swift
//  FlowCustApp
//
//  Created by Thana Priya on 18/04/1944 Saka.
//  Copyright © 1944 comorins. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject private var loginVM = LoginViewModel()
    @State var pin = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                VStack{
                    VStack {
                        Image("flowLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:250,height:100)
                            .padding(.top,100)
                        Text("Hi John!")
                            .padding()
                            .padding(.top,10)
                            .frame( maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                            .foregroundColor(Color.white)
                    }
                    VStack(alignment: .center) {
                        Spacer()
                        Text("Enter 4 Digit Login Pin")
                            .padding(.bottom, 40)
                            .font(.title)
                        TextField("Pin",text: $pin)
                            .padding()
                            .multilineTextAlignment(.center)
                        Button( action: {
                            self.loginVM.doLogin(param: [
                                "country_code": "UGA",
                                "mobile_num": "756729120",
                                "pin": self.pin
                            ])
                        } ){
                            Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width:180,height:50)
                            .background(Color.blue)
                            .cornerRadius(15)
                        }.padding(.vertical,40)
                        NavigationLink(destination: ImagePicker()) {
                            Text("Access photos").padding(.vertical,20)
                        }
                        NavigationLink(destination: ContactPickerView()) {
                            Text("Access Contacts").padding(.bottom,20)
                        }
                        Text("APP VERSION : TEST-20220701")
                            .font(.footnote)
                            .padding()
                        Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(20)
                }
                NavigationLink("", destination: HomeView(), isActive: $loginVM.isLoggedIn)
            } .edgesIgnoringSafeArea([.vertical])
        }.environmentObject(loginVM)
    }
}

struct UsernameTextField: View {
    @Binding var pin: String
    var body: some View {
        TextField("UserName", text: $pin)
        .padding()
        .cornerRadius(5)
    }
}

struct PasswordSecureField: View {
    @Binding var password: String
    var body: some View {
        SecureField("Password", text: $password)
        .padding()
        .background(Color.gray)
        .cornerRadius(5)
        .padding(.bottom,20)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
