//
//  PurchaseError.swift
//  
//
//  Created by Jeremy Greenwood on 1/23/21.
//

import Foundation

public enum PurchaseError: Error, Equatable {
    case cannotFindProduct
    case cannotMakePurchases
    case cannotFindReceipt
    case restoreFailed
    case invalidReceipt
    case purchaseFailed
}
