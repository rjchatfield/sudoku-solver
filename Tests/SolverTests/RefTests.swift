import XCTest
import SudokuSolverRef

final class RefTests: XCTestCase {
    
    /*
     Timing = iPad -> Initial Mac in Release -> Mac with improvements
     Counts: given -> [number of loops trying to calculate valid guesses]
        - W/O = without calculateNakedPairs()
        - W/O = with calculateNakedPairs()
     */
    
    func testEasy() {
        // 6ms -> 0.3ms -> 0.4ms
        // W/O : 43 -> [66, 79, 81, 81]
        // With: 43 -> [67, 79, 79]
        measure {
            grid = Grid(initial: Example.easy)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
    func testMedium() {
        // 9ms -> 0.5ms -> 0.5ms
        // W/O : 34 -> [46, 70, 81, 81]
        // With: 34 -> [49, 67, 73, 75, 75]
        measure {
            grid = Grid(initial: Example.medium)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
    func testHard() {
        // 12ms -> 0.7ms -> 0.8ms
        // W/O : 29 -> [34, 39, 47, 59, 68, 77, 80, 81, 81]
        // With: 29 -> [34, 41, 50, 56, 63, 70, 72, 72]
        measure {
            grid = Grid(initial: Example.hard)
            XCTAssert(grid.solve(), "Expected to solve")
        }
    }
    
    func testExpert() {
        // 1_486ms -> 63ms -> ~110-1ms
        // W/O : 25 -> [25]
        // With: 25 -> [25]
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
