//
//  ContentView.swift
//  CLAnimatedTabViewExample
//
//  Created by Chris Larsen on 4/14/24.
//

import SwiftUI
import CLAnimatedTabView

struct ContentView: View {
    var body: some View {
        let viewModel = CLAnimatedTabViewModel(tabBarHeight: 69.0, tabNames: ["Tab 1", "Tab 2", "Tab 3"])
        CLAnimatedTabView(viewModel: viewModel) {
            Text("1")
            Text("2")
            Text("3")
        }
    }
}

#Preview {
    ContentView()
}
