//
//  homePage.swift
//  test
//
//  Created by 林京緯 on 2024/4/15.
//

import SwiftUI

struct homePage: View {
    @EnvironmentObject var isLog : IsLog
    @State private var isLogout = false
    @State private var userName = "芬薇"
    var body: some View {
        NavigationStack {
            VStack{
                HStack(content: {
                    Spacer()
                    Text("嗨，\(userName)       ")
                })
                Spacer()
                    .frame(height:80)
                Text("開始你的冒險吧")
                
                Spacer()
                HStack{
                    NavigationLink("beacon"){
                        RangeBeaconView()
                    }
                    
                    Text("|")
                    NavigationLink("點數"){
                        pointView()
                    }
                    
                    Text("|")
                    NavigationLink("闖關"){
                        BreakthroughView()
                    }
                    
                    Text("|")
                    NavigationLink("人流"){
                        peopleFlow()
                    }
                    
                    Text("|")
                    NavigationLink("個人資訊"){
                        userInformation()
                    }
        
                    .alert("確定登出？", isPresented: $isLogout, actions: {
                        Button("確定"){
                            isLog.isLogin.toggle()
                        }
                        Button("取消"){
                            
                        }
                    })
                }
            }
            .background(
                Image("homePageBackground")
                    .resizable(resizingMode: .stretch)
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                            
        )
        }
    }
}

#Preview {
    homePage().environmentObject(IsLog())
}
