import XCTest
import SudokuSolverRef

final class RefTests: XCTestCase {
    
    var grid = Grid(initial: Example.easy)
    
    func testEasy() {
        // 6ms -> 0.3ms -> 0.4ms (.0003)
        measure {
            grid = Grid(initial: Example.easy)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
    func testMedium() {
//        var grid = Grid(initial: Example.medium)
        // 9ms -> 0.5ms -> 0.6ms (.0003)
        measure {
            grid = Grid(initial: Example.medium)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
    func testHard() {
//        var grid = Grid(initial: Example.hard)
        // 12ms -> 0.7ms -> 0.8ms (.0006)
        measure {
            grid = Grid(initial: Example.hard)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
    func testExpert() {
//        var grid = Grid(initial: Example.expert)
        // 1_486ms -> 63ms -> 163-70-4ms
        measure {
            grid = Grid(initial: Example.expert)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
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
