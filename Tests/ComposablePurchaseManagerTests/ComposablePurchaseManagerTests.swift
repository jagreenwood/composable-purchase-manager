import XCTest
@testable import ComposablePurchaseManager

final class ComposablePurchaseManagerTests: XCTestCase {
    func testEquatable() {
        let uuid = UUID()
        let data = Data()
        
        let validation_1 = ReceiptValidation(
            id: uuid,
            data: data,
            success: { print("success_validation_1") },
            failure: { print("failure_validation_1") })
        
        let validation_2 = ReceiptValidation(
            id: uuid,
            data: data,
            success: { print("success_validation_2") },
            failure: { print("failure_validation_2") })
        
        XCTAssertEqual(validation_1, validation_2, "Validation instances were expected to be equal, but are not.")
    }

    static var allTests = [
        ("testEquatable", testEquatable),
    ]
}
