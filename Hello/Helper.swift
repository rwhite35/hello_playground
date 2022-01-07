//
//  Helper.swift
//  Hello
//
//  Created by Ron White on 1/7/22.
//

import Foundation
import UIKit

extension Bundle
{
    /// extend Bundle to decode nav.json file
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T
    {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle!.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle!")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file).")
        }
        
        return loaded
    }
}
