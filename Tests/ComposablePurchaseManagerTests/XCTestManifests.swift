import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(composable_purchase_managerTests.allTests),
    ]
}
#endif
