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
        get { rows[point.row].cells[point.col] }
        _modify { yield &rows[point.row].cells[point.col] }
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
            let block = Point(col: point.col/3, row: point.row/3)
            for i in 1...9 where isValid(i, point, block) {
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
    
    public func isValid(_ i: Int, _ point: Point, _ block: Point) -> Bool {
        for (colIdx, colBlock) in theIndicies {
            let sameXBlock = colBlock == block.col
            for (rowIdx, rowBlock) in theIndicies {
                let sameYBlock = rowBlock == block.row
                let p = Point(col: colIdx, row: rowIdx)
                
                // Ignore same cell
                guard p != point else { continue }
                // Same y-axis, x-axis, or block
                guard rowIdx == point.row
                    || colIdx == point.col
                    || (sameXBlock && sameYBlock)
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
