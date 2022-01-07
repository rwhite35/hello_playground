//
//  Navigate.swift
//  Hello
//
//  Created by Ron White on 1/7/22.
//

import SwiftUI

/// top level parent navigation
/// can have one or more child sub sections
struct NavigateSection: Codable, Identifiable
{
    var id: UUID
    var name: String
    var items: [NavigateLinks]
}

/// each application sections
struct NavigateLinks: Codable, Equatable, Identifiable
{
    var id: UUID
    var name: String
    var attribute: [String]
    
}


