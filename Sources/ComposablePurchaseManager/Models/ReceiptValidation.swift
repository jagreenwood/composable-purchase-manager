//
//  ReceiptValidation.swift
//  
//
//  Created by Jeremy Greenwood on 1/23/21.
//

import Foundation

public struct ReceiptValidation: Equatable {
    public static func == (lhs: ReceiptValidation, rhs: ReceiptValidation) -> Bool {
        lhs.id == rhs.id && lhs.data == rhs.data
    }
    
    public let id = UUID()
    public let data: Data
    public let success: () -> ()
    public let failure: () -> ()
}
