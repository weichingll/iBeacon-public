//
//  newbalance.swift
//  test
//
//  Created by 林京緯 on 2024/5/5.
//

import SwiftUI

struct newbalance: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack{
                Image("NB")
                    .resizable()
                    .scaledToFit()
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                
                Text("New balance")
                    .foregroundStyle(.white)
                
                Rectangle()
                    .frame(height: 1)
                    //Color(red: 87, green: 227, blue: 88)
                    .foregroundColor(.white)
                    .padding(.leading, 80)
                    .padding(.trailing, 80)
                
                Text("我們代表著的，是遠比運動鞋重要的事。我們全力支持充滿熱情而無畏無懼的每個人。我們致力提升運動的水平。我們在人類和地球之間做著正確的事。我們努力不懈，推動世界各地的社區作出有意義的改變。")
                    .foregroundStyle(.white)
                    .padding(.leading, 80)
                    .padding(.trailing, 80)
                
                Rectangle()
                    .frame(height: 1)
                    //Color(red: 87, green: 227, blue: 88)
                    .foregroundColor(.white)
                    .padding(.leading, 80)
                    .padding(.trailing, 80)
                
                Text("當期資訊:")
                    .foregroundStyle(.white)
                Text("1.當季球鞋兩件8折")
                    .foregroundStyle(.white)
                Text("2.325新配色上市囉")
                    .foregroundStyle(.white)
            }
        }
        
    }
}

#Preview {
    newbalance()
}
