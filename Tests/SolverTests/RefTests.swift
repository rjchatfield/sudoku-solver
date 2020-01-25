import XCTest
import SudokuSolverRef

final class RefTests: XCTestCase {
    func testEasy() {
        var grid = Grid(initial: Example.easy)
        // 6ms -> 0.3ms
        measure {
            grid = Grid(initial: Example.easy)
            XCTAssert(grid.solveTheRest(), "Expected to solve")
        }
    }
    
    func testMedium() {
        var grid = Grid(initial: Example.medium)
        // 9ms -> 0.5ms
        measure {
            grid = Grid(initial: Example.medium)
            XCTAssert(grid.solveTheRest(), "Expected to solve")
        }
    }
    
    func testHard() {
        var grid = Grid(initial: Example.hard)
        // 12ms -> 0.7ms
        measure {
            grid = Grid(initial: Example.hard)
            XCTAssert(grid.solveTheRest(), "Expected to solve")
        }
    }
    
    func testExpert() {
        var grid = Grid(initial: Example.expert)
        // 1_486ms -> 63ms
        measure {
            grid = Grid(initial: Example.expert)
            XCTAssert(grid.solveTheRest(), "Expected to solve")
        }
    }
    
    static var allTests = [
        ("testEasy", testEasy),
        ("testMedium", testMedium),
        ("testHard", testHard),
        ("testExpert", testExpert),
    ]
}
