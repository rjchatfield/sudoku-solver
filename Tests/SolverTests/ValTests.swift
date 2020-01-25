import XCTest
import SudokuSolverVal

final class ValTests: XCTestCase {
    func testEasy() {
        var grid = Grid(initial: Example.easy)
        // 5ms -> 0.09ms
        measure {
            grid = Grid(initial: Example.easy)
            XCTAssert(grid.solveTheRest(), "Expected to solve")
        }
    }
    
    func testMedium() {
        var grid = Grid(initial: Example.medium)
        // 187ms -> 1.5ms
        measure {
            grid = Grid(initial: Example.medium)
            XCTAssert(grid.solveTheRest(), "Expected to solve")
        }
    }
    
    func testHard() {
        var grid = Grid(initial: Example.hard)
        // 52ms -> 0.5ms
        measure {
            grid = Grid(initial: Example.hard)
            XCTAssert(grid.solveTheRest(), "Expected to solve")
        }
    }
    
    func testExpert() {
        var grid = Grid(initial: Example.expert)
        // 31_551.10ms -> 189ms
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
