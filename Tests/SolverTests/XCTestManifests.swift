import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ValTests.allTests),
        testCase(RefTests.allTests),
    ]
}
#endif
