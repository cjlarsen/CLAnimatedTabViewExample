// CLAnimatedTabView
//
// Created by Christopher Larsen 4/14/24
/*
 The MIT License (MIT)
 Copyright © 2024 Christopher Larsen
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import Foundation
import SwiftUI

struct CLAnimatedTabView<Content: View>: View {
    
    @State var currentTab: Int = 0
    @ObservedObject var viewModel: CLAnimatedTabViewModel
    var views: [Content]
    
    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $currentTab) {
                ForEach(views.indices, id: \.self) { index in
                    views[index]
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .animation(.easeInOut, value: currentTab)
            .padding(.top, viewModel.tabBarHeight)
            
            TabBarView(currentTab: $currentTab,
                       tabBarItemNames: $viewModel.tabNames)
            .frame(height: viewModel.tabBarHeight)
            .cornerRadius(0)
            .shadow(color: Color.black.opacity(viewModel.shadowOpacity),
                    radius: viewModel.shadowRadius,
                    x: viewModel.shadowX,
                    y: viewModel.shadowY)
        }
    }
}

struct TabBarView: View {
    struct Constants {
        static let backgroundColor = Color.white
    }
    
    @Binding var currentTab: Int
    @Namespace var namespace
    @Binding var tabBarItemNames: [String]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(tabBarItemNames.enumerated()),
                    id: \.0,
                    content: { index, name in
                TabBarItem(currentTab: $currentTab,
                           isSelected: index == 0,
                           name: name,
                           tab: index,
                           namespace: namespace)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Constants.backgroundColor)
            })
        }
    }
}

struct TabBarItem: View {
    struct Constants {
        static let underlineId = "underline"
        static let barHeight = 2.0
        static let font = Font.system(size: 15.0)
        static let backgroundColor = Color.white
        static let textInactiveColor = Color.brown
        static let textActiveColor = Color.blue
        static let transitionScale = 1.0
    }
    
    @Binding var currentTab: Int
    @State var isSelected: Bool = false
    
    var name: String
    var tab: Int
    
    let namespace: Namespace.ID
    
    var body: some View {
        
        Button(action: {
            self.currentTab = tab
        }, label: {
            VStack {
                Spacer()
                Text(name)
                    .font(Constants.font)
                    .frame(alignment: .center)
                    .onChange(of: currentTab) {
                        isSelected = (currentTab == tab)
                    }
                
                Spacer()
                ZStack {
                    if currentTab == tab {
                        Capsule(style: .continuous)
                            .fill(Color.blue)
                            .frame(height: Constants.barHeight)
                            .matchedGeometryEffect(id: Constants.underlineId,
                                                   in: namespace)
                            .transition(.asymmetric(insertion: .scale(scale: Constants.transitionScale), removal: .slide))
                    } else {
                        Capsule()
                            .fill(Color.clear)
                            .frame(height: Constants.barHeight)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .bottom)
            }
        })
        .buttonStyle(NotificationCenterTabViewButtonStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.spring(), value: currentTab)
        .background(Constants.backgroundColor)
        .accentColor(isSelected ? Constants.textActiveColor : Constants.textInactiveColor)
    }
}

struct NotificationCenterTabViewButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .foregroundColor(.accentColor)
    }
}


