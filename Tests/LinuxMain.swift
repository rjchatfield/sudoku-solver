import XCTest

import SolverTests

var tests = [XCTestCaseEntry]()
tests += RefTests.allTests()
tests += ValTests.allTests()
XCTMain(tests)
