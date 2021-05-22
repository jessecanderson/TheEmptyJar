//
//  RootView.swift
//  TheEmptyJar
//
//  Created by Jesse Anderson on 5/21/21.
//  Copyright © 2021 Jesse Anderson. All rights reserved.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            NoteView()
                .tabItem {
                    Label("Notes", systemImage: "house")
                    
                }
            
            TimelineView()
                .tabItem {
                    Label("Jar", systemImage: "list.bullet.indent")
                }
            
            AboutView()
                .tabItem {
                    Label("About", systemImage: "gear")
                }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
