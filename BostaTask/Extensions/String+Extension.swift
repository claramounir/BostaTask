//
//  String+Extension.swift
//  BostaTask
//
//  Created by Clara Mounir Adly on 17/12/2024.
//

import Foundation
extension String {
    var asUrl : URL? {
        return URL(string: self)
    }
    
}
