//
//  HomeView.swift
//  FlowCustApp
//
//  Created by Thana Priya on 18/04/1944 Saka.
//  Copyright © 1944 comorins. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var login : LoginViewModel
    @ObservedObject private var recentfasVM = RecentFAsListModel()
    
    var body: some View {
        List(recentfasVM.recentfas){ fa in
            VStack {
                VStack {
                    Text("Float Advance")
                        .font(.title)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Float Advance")
                                .font(.headline)
                            Text("\(fa.amt)")
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Fee")
                                .font(.headline)
                            Text("\(fa.fee)")
                        }
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Disbursed on")
                                .font(.headline)
                            Text("\(fa.disDt)")
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Paid on")
                                .font(.headline)
                            Text("\(fa.payDt)")
                        }
                    }
                    .padding(.vertical)
                    Button( action: {print("repeat")}){
                        Text("Repeat FA")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width:130,height:40)
                        .background(Color.blue)
                        .cornerRadius(15)
                    }
                }
                .padding()
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red:150/255, green:150/255, blue:150/255, opacity: 0.1),lineWidth: 1)
            )
            .padding([.top])
        }
        .navigationBarTitle("Home Screen", displayMode: .inline)
        .onAppear {
            self.recentfasVM.fetchrecentfas(param: [
                "token" : self.login.token
            ])
            UITableView.appearance().separatorStyle = .none
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
