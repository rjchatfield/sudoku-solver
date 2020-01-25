import XCTest
import SudokuSolverVal

final class ValTests: XCTestCase {
    
    func testEasy() {
        // 5ms -> 0.09ms -> 0.1ms
        measure {
            grid = Grid(initial: Example.easy)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
    func testMedium() {
        // 187ms -> 1.5ms -> 0.3ms
        measure {
            grid = Grid(initial: Example.medium)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
    func testHard() {
        // 52ms -> 0.5ms - 0.2ms
        measure {
            grid = Grid(initial: Example.hard)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
    func testExpert() {
        // 31_551.10ms -> 189ms -> 32ms
        measure {
            grid = Grid(initial: Example.expert)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
    var grid: Grid!
    
    static var allTests = [
        ("testEasy", testEasy),
        ("testMedium", testMedium),
        ("testHard", testHard),
        ("testExpert", testExpert),
    ]
}
