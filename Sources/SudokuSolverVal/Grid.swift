public struct Grid: Equatable, Hashable {
    public var rows: [Row] = (0...9).map { _ in Row() }
}
extension Grid: CustomDebugStringConvertible {
    public init(initial: String) {
        rows = initial
            .split(separator: "\n")
            .map(Row.init)
    }
    
    public subscript(point: Point) -> Cell {
        get { rows[point.y].cells[point.x] }
        _modify { yield &rows[point.y].cells[point.x] }
    }
    
    public var debugDescription: String {
        var lines = rows.map { row -> String in
            let t = row.cells.map { $0.value.map(String.init) ?? "_" }
            return "|  \(t[0]) \(t[1]) \(t[2])  |  \(t[3]) \(t[4]) \(t[5])  |  \(t[6]) \(t[7]) \(t[8])  |"
        }
        lines.insert(String(repeating: "—", count: 11), at: 3)
        lines.insert(String(repeating: "—", count: 11), at: 7)
        return lines.joined(separator: "\n")
    }
}

// MARK: - Logic

extension Grid {
    
    public mutating func solveTheRest(from point: Point = .zero) -> Bool {
        let next = point.next()
        switch self[point] {
        case .given:
            guard let next = next else {
                // Finished
                return true
            }
            let isAllSolved = solveTheRest(from: next)
            return isAllSolved
            
        case .guess:
            let section = Point(x: point.x/3, y: point.y/3)
            for i in 1...9 where isValid(i, point, section) {
                self[point] = .guess(i)
                
                guard let next = next else {
                    // Finished
                    return true
                }
                let isAllSolved = solveTheRest(from: next)
                
                if isAllSolved {
                    // Finished
                    return true
                }
                
                // else, this guess did not lead to a valid conclusion, so we try a different guess and do it all again.
            }
            
            // Not solved, so ignore any guesses
            self[point] = .guess(nil)
            return false
        }
    }
    
    public func isValid(_ i: Int, _ point: Point, _ section: Point) -> Bool {
        for (xIdx, xSection) in theIndicies {
            let sameXSec = xSection == section.x
            for (yIdx, ySection) in theIndicies {
                let sameYSec = ySection == section.y
                let p = Point(x: xIdx, y: yIdx)
                
                // Ignore same cell
                guard p != point else { continue }
                // Same y-axis, x-axis, or section
                guard yIdx == point.y
                    || xIdx == point.x
                    || (sameXSec && sameYSec)
                    else { continue }
                
                if self[p].value == i {
                    return false
                }
            }
        }
        
        // all good!
        return true
    }
    
}

let theIndicies = (0..<9).map { ($0, $0/3) }
