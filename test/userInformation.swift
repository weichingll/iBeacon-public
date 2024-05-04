//
//  userInformation.swift
//  test
//
//  Created by 林京緯 on 2024/5/4.
//

import SwiftUI

struct userInformation: View {
    @EnvironmentObject var isLog : IsLog
    @State private var islogout = false
    var body: some View {
        VStack{
            Text("個人資訊")
            Spacer()
            Button{
                //isLog.isLogin = false
                islogout.toggle()
            } label : {
                Text("登出")
            }
        }
        
        .alert("確定要登出？",isPresented: $islogout) {
            Button("確定"){
                isLog.isLogin = false
            }
            Button("取消"){
                
            }
        }
    }
}

#Preview {
    userInformation()
}
