//
//  homePage.swift
//  test
//
//  Created by 林京緯 on 2024/4/15.
//

import SwiftUI

struct homePage: View {
    @EnvironmentObject var isLog : IsLog
    var body: some View {
        Text("主頁")
        HStack{
            Button("點數"){
                
            }
            Text("|")
            Button("闖關"){
                
            }
            Text("|")
            Button("人流"){
                
            }
            Text("|")
            Button("個人資訊"){
                isLog.isLogin.toggle()
                
            }
        }
    }
}

#Preview {
    homePage().environmentObject(IsLog())
}
