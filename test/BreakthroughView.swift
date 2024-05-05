//
//  BreakthroughView.swift
//  test
//
//  Created by 林京緯 on 2024/5/4.
//

import SwiftUI

class Isshow : ObservableObject {
     public var isShowSearch = false//雷達圖是出現
    public var showgift = false
    
}
struct BreakthroughView: View {
    @EnvironmentObject var isshow : Isshow
    @State private var NBscuess = false
    @State private var CHscuess = false
    @State private var OHscuess = false
    @State private var isshowalert = false
    @State private var isshowalert2 = false //double check
    @State private var finish = false //是否兌換過禮物
    @State private var showGift = false //顯示兌換按鈕
    @State private var fail = false //如果沒偵測到
    var body: some View {
        ZStack {
            Image("breakBackground")
                .resizable(resizingMode: .stretch)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                            
            VStack {
                Text("闖關囉！")
                    .font(.largeTitle)
                    .position(x: 250,y:80)
                 
                HStack{
                    Spacer()
                        .frame(width: 80)
                        Image("NB")
                            .resizable()
                            .scaledToFit()
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            .position(x:40,y:130)
                        Image("chanel")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .position(x:40,y:130)
                        Image("oldcheers")
                            .resizable()
                            .scaledToFit()
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            .scaledToFill()
                            .clipShape(Circle())
                            .position(x:30,y:130)
                    Spacer()
                            
                }
                HStack{
                    Spacer()
                        .frame(width: 150)
                    Button{
                        //isshow.isShowSearch.toggle()
                        //fail = true
                        if (fail == false){
                            NBscuess = true
                        }
                    }label: {
                        if (NBscuess == false){
                            Text("我要打卡！")
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(100)
                                .position(x:-25,y:20)
                        }else{
                            Text("成功！")
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(100)
                                .position(x:-25,y:20)
                        }
                        
                    }
                    
                    Button{
                        //isshow.isShowSearch.toggle()
                        if (fail == false){
                            CHscuess = true
                        }
                        CHscuess = true
                    }label: {
                        if (CHscuess == false){
                            Text("我要打卡！")
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(100)
                                .position(x:-25,y:20)
                        }else{
                            Text("成功！")
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(100)
                                .position(x:-25,y:20)
                        }
                    }
                    Button{
                        //isshow.isShowSearch.toggle()
                        if (fail == false){
                            OHscuess = true
                        }
                        OHscuess = true
                    }label: {
                        if (OHscuess == false){
                            Text("我要打卡！")
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(100)
                                .position(x:-25,y:20)
                        }else{
                            Text("成功！")
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(100)
                                .position(x:-25,y:20)
                        }
                    }
                }
                if(NBscuess && CHscuess && OHscuess && !finish){
                    Button("兌換禮物"){
                        isshowalert.toggle()
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(100)
                }
                if(finish){
                    Text("已兌換完成！")
                        .foregroundStyle(.white)
                }
            }
        }
        .alert("偵測失敗，請再靠近櫃位",isPresented:$fail ){
            Button("好的"){
                
            }
        }
        
        .alert("可以兌換禮物囉", isPresented: $isshowalert){
            Button("兌換"){
                isshowalert2.toggle()
            }
            Button("ok!"){
                //isshowalert.toggle()
            }
        }message: {
            Text("櫃檯在1F出口旁")
                .foregroundStyle(.red)
        }
        
        .alert("此按鈕限工作人員使用",isPresented: $isshowalert2){
            Button("我不是工作人員"){
                //isshowalert2.toggle()
            }
            Button("確定，已要兌換禮物"){
                finish = true
            }
        }
    }
}

#Preview {
    BreakthroughView().environmentObject(Isshow())
}
