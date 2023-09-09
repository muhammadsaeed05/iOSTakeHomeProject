//
//  ContentView.swift
//  iOSTakeHomeProject
//
//  Created by Muhammad Saeed on 30/08/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                print("Single User Response")
                dump(
                    try? StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
                )  
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
