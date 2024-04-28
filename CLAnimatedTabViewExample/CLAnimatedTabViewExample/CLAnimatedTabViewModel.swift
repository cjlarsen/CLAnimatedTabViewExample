//
//  File.swift
//
//
//  Created by Chris Larsen on 4/14/24.
//

import SwiftUI

public class CLAnimatedTabViewModel: ObservableObject {
    /// Height for tab bar
    /// # Notes #
    /// Default value is 48.0
    @Published var tabBarHeight = 48.0
    /// Background color for entire view
    /// # Notes #
    /// Default value is white
    @Published var backgroundColor = Color.white
    /// Enable or disable tab bar shadow
    /// # Notes #
    /// Default set to true
    @Published var displayTabBarShadow = true
    /// Opacity for tab bar shadow
    /// # Notes #
    /// Default opacity 0.13
    @Published var shadowOpacity = 0.13
    /// Radius for tab bar shadow
    /// # Notes #
    /// Default is 2.0
    @Published var shadowRadius = 2.0
    /// X position for tab bar shadow
    /// # Notes #
    /// Default is 0
    @Published var shadowX = 0.0
    /// Y position for tab bar shadow
    /// # Notes #
    /// Default is 2.0
    @Published var shadowY = 2.0
    /// Text to display in each tab of view
    @Published public var tabNames: [String]
    
    init(tabNames: [String]) {
        self.tabNames = tabNames
    }
}
