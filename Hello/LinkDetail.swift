//
//  LinkDetail.swift
//  Hello
//
//  This is the detail view the navigation link displays
//
//  Created by Ron White on 1/7/22.
//

import SwiftUI

struct LinkDetail: View
{
    let item: NavigateLinks
    
    func getID(uuid: UUID) -> String
    {
        let id = String(uuid.uuidString)
        let chop = String(id.prefix(4))
        return chop
    }
    
    var body: some View {
        VStack {
            Text("Link ID: \(getID(uuid: item.id))")
                .padding(4)
            
            Button("Visit") {
                    // do something clever
            }
            // done with layout
            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
