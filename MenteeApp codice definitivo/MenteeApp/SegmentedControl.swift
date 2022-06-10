//
//  SegmentedControl.swift
//  Mentee
//
//  Created by Fabiana Falgiano on 22/11/21.
//

import SwiftUI

struct SegmentedControl: View {
    
    @State private var selectorIndex = 0
    @State private var status = ["To Do","Done"]
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                Picker("Status", selection: $selectorIndex) {
                    ForEach(0 ..< status.count) { index in
                        Text(self.status[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
            }
        }
    }
}

struct SegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControl()
    }
}

