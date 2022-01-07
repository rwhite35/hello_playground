//
//  LinkRow.swift
//  Hello
//
//  This is the row of text navigation link displays
//
//  Created by Ron White on 1/7/22.
//

import SwiftUI

struct LinkRow: View
{
    let item: NavigateLinks
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Go \(item.name)")
                    .padding(2)
            }
            /// process the attributes for some additional styling
            ForEach(item.attribute, id: \.self) { attribute in
                let _ = print("LinkRow \(#line) handling attribute \(attribute)")
                if(attribute == "A") {
                    Text(attribute)
                        .padding(2)
                }
            }
        }
    }
}
