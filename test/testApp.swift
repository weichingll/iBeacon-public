//
//  testApp.swift
//  test
//
//  Created by 林京緯 on 2024/3/28.
//

import SwiftUI

@main
struct testApp: App {
    var body: some Scene {
        WindowGroup {
            mainView().environmentObject(IsLog()).environmentObject(data_link())
        }

    }
}
