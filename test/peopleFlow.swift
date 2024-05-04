//
//  peopleFlow.swift
//  test
//
//  Created by 林京緯 on 2024/5/3.
//

import SwiftUI

struct peopleFlow: View {
    @State private var people = 3
    var body: some View {
            VStack{
                Text("目前人流數")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                ZStack{
                    Image("peopleBackground")
                        .resizable()
                        .scaledToFit()
                    VStack{
                        Spacer()
                            .frame(height: 50)
                        Text("目前人數:")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                        Spacer()
                            .frame(height: 40)
                        Text("\(people)")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                        Spacer()
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        
                    }
                    
                }
                
                  }
            .background(
                Image("peopleFlowBackgroung")
                    .resizable(resizingMode: .stretch)
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                            
        )
            .navigationTitle("人流")
            
      
        
    }
}

#Preview {
    peopleFlow()
}
