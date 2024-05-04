//
//  registerView.swift
//  test
//
//  Created by 林京緯 on 2024/5/3.
//
/*
import SwiftUI

struct registerView : View {
    @EnvironmentObject var isLog : IsLog
    @EnvironmentObject var data : data_link
    @State private var userName : String = ""
    @State private var userAccount : String = ""
    @State private var userPassword : String = ""
    @State private var userdate = Date()//生日
    //@State private var phoneNumber : String = ""
    @State private var useremail : String = ""
    @State private var isShowRegisterSucess = false
    @State private var isShowRegisterFail = false

    var body: some View {
        VStack{
            Text("姓名：")
                .padding()
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
            SecureField("密碼", text : $userPassword)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
            Text("生日：")
                .frame(height: 45)
            DatePicker(
                "生日",
                selection: $userdate,
                displayedComponents: [.date]
            ).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            Text("電子郵件")
                .frame(height: 45)
            TextField("email", text : $useremail)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
            HStack{
                Button("註冊"){
                    data.loadData_Account{ accountData in
                        print(accountData)
                        if (!accountData.contains(userAccount) && userName != "" && userAccount != "" && userPassword != "" && useremail != ""){
                            print("YES")
                            let userdata = database_user(records: [.init(fields: .init(user: userAccount, password: userPassword, name: userName, date: userdate, email: useremail))])
                            data.uploadData(userdata)
                            isShowRegisterSucess.toggle()
                            
                        }else{
                            print("NO")
                            isShowRegisterFail.toggle()
                        }
                    }
                }
                
                Button("取消註冊"){
                    isShowRegisterSucess.toggle()
                }
                
            }
           
            
            
            
            
            .alert("註冊成功", isPresented : $isShowRegisterSucess){
                Button("ok"){
                    isLog.Register.toggle()
                }
            }message: {
                Text("返回登入介面重新登入")
            }
            .alert("註冊失敗", isPresented : $isShowRegisterFail){
                Button("ok"){
                }
            }
        }
    }
}

*/
