import XCTest
import SudokuSolverRef

final class RefTests: XCTestCase {
    
    func testEasy() {
        // 6ms -> 0.3ms -> 0.4ms
        measure {
            grid = Grid(initial: Example.easy)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
    func testMedium() {
        // 9ms -> 0.5ms -> 0.5ms
        measure {
            grid = Grid(initial: Example.medium)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
    func testHard() {
        // 12ms -> 0.7ms -> 0.8ms
        measure {
            grid = Grid(initial: Example.hard)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
    func testExpert() {
        // 1_486ms -> 63ms -> ~110-1ms
        measure {
            grid = Grid(initial: Example.expert)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
    var grid = Grid(initial: Example.easy)
    
    static override func setUp() {
        super.setUp()
        print(Set.oneToNine)
    }
    
    static var allTests = [
        ("testEasy", testEasy),
        ("testMedium", testMedium),
        ("testHard", testHard),
        ("testExpert", testExpert),
    ]
}
