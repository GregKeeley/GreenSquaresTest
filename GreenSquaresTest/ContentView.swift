//
//  ContentView.swift
//  GreenSquaresTest
//
//  Created by Gregory Keeley on 5/26/21.
//

import SwiftUI

struct ContentView: View {
    
    private var colors: [Color] = [ Color(red: 22 / 255, green: 28 / 255, blue: 34 / 255),
                                    Color(red: 14 / 255, green: 67 / 255, blue: 41 / 255),
                                    Color(red: 2 / 255, green: 109 / 255, blue: 50 / 255),
                                    Color(red: 38 / 255, green: 166 / 255, blue: 65 / 255),
                                    Color(red: 57 / 255, green: 211 / 255, blue: 83 / 255)]
    private var gridItemLayout = [GridItem(.adaptive(minimum: 20))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 0) {
                ForEach((0...365), id: \.self) {
                    Image("")
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 20)
                        .background(colors[($0 + Int(Double.random(in: 1.0 ... 5.0))) % colors.count])
                        .cornerRadius(4)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

