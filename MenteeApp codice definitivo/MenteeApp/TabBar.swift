//
//  TabBar.swift
//  Mentee
//
//  Created by Fabiana Falgiano on 22/11/21.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView() {
            ContentView()
                .tabItem {
                    Text("TASKS")
                    Image(systemName: "checkmark")
                }.tag(1)
            
            TimerView()
                .tabItem {
                    Text("TIMER")
                    Image(systemName: "timer")
                }.tag(2)
            
        }.accentColor(.orange)
        
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

