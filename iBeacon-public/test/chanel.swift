//
//  chanel.swift
//  test
//
//  Created by 林京緯 on 2024/5/5.
//

import SwiftUI

struct chanel: View {
    var body: some View {
        VStack{
            Image("chanel")
                .resizable()
                .scaledToFit()
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            Rectangle()
                .frame(height: 1)
                //Color(red: 87, green: 227, blue: 88)
                .foregroundColor(.black)
                .padding(.leading, 80)
                .padding(.trailing, 80)
            Text("Chanel")
                .font(.largeTitle)
            Rectangle()
                .frame(height: 1)
                //Color(red: 87, green: 227, blue: 88)
                .foregroundColor(.black)
                .padding(.leading, 80)
                .padding(.trailing, 80)
            
            Text("CHANEL的傳奇故事，從1910年開始，CHANEL能夠屹立至今一個世紀，就是因為Karl Lagerfeld一直堅守Coco Chanel的美學概念，藉著服裝設計傳遞獨立自主的時尚態度，就算如何經歷時間洗禮，依然能夠讓人產生共鳴。「解放」、「獨立」和「大膽」成為CHANEL的代名詞，百年過後依然傳頌至今")
                .padding(.leading, 80)
                .padding(.trailing, 80)
            Rectangle()
                .frame(height: 1)
                //Color(red: 87, green: 227, blue: 88)
                .foregroundColor(.black)
                .padding(.leading, 80)
                .padding(.trailing, 80)
            
            Text("當期資訊")
            Text("1.CHANEL 22 迷你包上市")
        }
    }
}

#Preview {
    chanel()
}
