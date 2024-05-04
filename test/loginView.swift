//
//  loginView.swift
//  test
//
//  Created by 林京緯 on 2024/4/14.
//

import SwiftUI


class IsLog : ObservableObject {
    @Published var isLogin = false //若false則顯示登入畫面或註冊
    @Published var Register = false
    @Published var BeaconPage = false
    
}

struct mainView:View {
    @EnvironmentObject var isLog : IsLog
    var body: some View {
        Group{
            if (isLog.isLogin == true){
                homePage()
                if (isLog.BeaconPage == true){
                    RangeBeaconView()
                }
            }else if(isLog.isLogin == false){
                if isLog.Register == true{
                    registerView()
                }else{
                    loginView()
                }
            }
        }}
}


/*
 struct mainView:View {
     @EnvironmentObject var isLog : IsLog
     var body: some View {
         Group{
             if (isLog.isLogin == true){
                 homePage()
                 if (isLog.BeaconPage == true){
                     RangeBeaconView()
                 }
             }else if(isLog.isLogin == false){
                 if isLog.Register == true{
                     registerView()
                 }else{
                     loginView()
                 }
             }
         }}
 }
 */

struct loginView : View {
    @State private var username: String = ""
    @State private var userPassword: String=""
    @State private var isRangeBeacon=false
    @EnvironmentObject var isLog : IsLog
    
    
    var body: some View {
        
        //zane-lee-IHj0xtWtLKE-unsplash 1
       /*
        Image(uiImage: #imageLiteral(resourceName: "zane-lee-IHj0xtWtLKE-unsplash 1"))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 390, height: 844)
            .clipped()
        .frame(width: 390, height: 844)
        */
            VStack{
                Spacer()
                HStack{
                    Text("Username:")
                        .font(.custom("Inter Regular", size: 12))
                        .foregroundStyle(.white)
                    Spacer()
                }
                
                    
                TextField("帳號", text: $username)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.automatic)
                    .colorInvert()
                    .font(.callout)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.underLine)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                
                
                
                //Password
                HStack{
                    Text("Password:")
                        .font(.custom("Inter Regular", size: 12))
                        //.foregroundColor(Color.black)
                        .foregroundStyle(.white)
                    Spacer()
                }

                
                SecureField("密碼",text: $userPassword)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.automatic)
                    .colorInvert()
                
                Rectangle()
                    .frame(height: 1)
                    //Color(red: 87, green: 227, blue: 88)
                    .foregroundColor(.underLine)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                
                HStack{
                    
                    Button{
                        isLog.Register = true
                    } label:{
                        Text("註冊")
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        
                    }
                    Text("|")
                        .foregroundStyle(.white)
                    
                    Button ("登入"){
                        isLog.isLogin = true
                    }
                }
                        
                    
            }
            .background(
                        Image("loginBackground")
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                    )
        }
    }

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
        //zane-lee-IHj0xtWtLKE-unsplash 1
        
        VStack{
            Text("註冊")
                .frame(height: 45)
                .foregroundStyle(.white)
                .font(.title)
            HStack{
                Text("姓名：")
                    .frame(height: 45)
                    .foregroundStyle(.white)
                Spacer()
            }
            
            TextField("姓名", text : $userName)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .frame(width: 300)
            HStack{
                Text("帳號：")
                    .frame(height: 45)
                    .foregroundStyle(.white)
                Spacer()
            }
            
            TextField("帳號", text : $userAccount)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .frame(width: 300)
            HStack{
                Text("密碼：")
                    .frame(height: 45)
                    .foregroundStyle(.white)
                Spacer()
            }
            SecureField("密碼", text : $userPassword)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .frame(width: 300)
                .padding()
            HStack{
                Text("生日：")
                    .frame(height: 45)
                    .foregroundStyle(.white)
                Spacer()
            }

            DatePicker(
                "生日",
                selection: $userdate,
                displayedComponents: [.date]
            ).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.white)
            HStack{
                Text("電子郵件")
                    .frame(height: 45)
                    .colorInvert()
                Spacer()
            }
            TextField("email", text : $useremail)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .frame(width: 300)
                .padding(/*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/)
            
            HStack{
                Button("取消"){
                    isLog.Register.toggle()
                }
                Text("|")
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
        .background(
                    Image("registBackground")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                )

    }
    
}

#Preview {
    mainView().environmentObject(IsLog()).environmentObject(data_link())
}
