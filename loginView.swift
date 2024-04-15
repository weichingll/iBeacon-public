//
//  loginView.swift
//  test
//
//  Created by 林京緯 on 2024/4/14.
//

import SwiftUI


class IsLog : ObservableObject {
    @Published var isLogin = false
    @Published var Register = false
}



struct mainView:View {
    @EnvironmentObject var isLog : IsLog
    var body: some View {
        Group{
            if(isLog.isLogin == false){
                if isLog.Register == true{
                    registerView()
                }else{
                    loginView()
                }
            }else if(isLog.isLogin == true){
                RangeBeaconView()
            }
        }}
}



struct loginView : View {
    @State private var username: String = ""
    @State private var userPassword: String=""
    @State private var isRangeBeacon=false
    @EnvironmentObject var isLog : IsLog
    
    var body: some View {
            VStack{
                TextField("帳號", text: $username)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                SecureField("密碼",text: $userPassword)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                HStack{
                    Button ("登入"){
                        isLog.isLogin = true
                    }
                        
                    Text("|")
                    Button("註冊"){
                        isLog.Register = true
                    }
                    
                        
                    }
            }
        }

    }

struct registerView : View {
    @EnvironmentObject var isLog : IsLog
    @State private var userName : String = ""
    @State private var userAccount : String = ""
    @State private var userPassword : String = ""
    @State private var date = Date()//生日
    @State private var phoneNumber : String = ""
    @State private var email : String = ""
    
    var body: some View {
        VStack{
            Text("姓名：")
                .frame(height: 45)
            TextField("姓名", text : $userName)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
            Text("帳號：")
                .frame(height: 45)
            TextField("帳號", text : $userAccount)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
            Text("密碼：")
                .frame(height: 45)
            TextField("密碼", text : $userPassword)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
            Text("生日：")
                .frame(height: 45)
            DatePicker(
                "生日",
                selection: $date,
                displayedComponents: [.date]
            ).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            Text("電子郵件")
                .frame(height: 45)
            TextField("email", text : $email)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
            Button("註冊"){
                isLog.Register = false
            }
            
        }
    }
}
/*
@State private var date = Date()

var body: some View {
    DatePicker(
        "Start Date",
        selection: $date,
        displayedComponents: [.date]
    )
}

*/


#Preview {
    mainView().environmentObject(IsLog())
}
