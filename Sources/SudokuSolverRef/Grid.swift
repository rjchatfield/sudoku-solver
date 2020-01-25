public final class Grid {
    
    let orderedCells: [Cell]
    var sortedCells: [Cell]
//    let houses: [House]
    let rows: [[Cell]]
    
    public init(initial: String) {
        // All cells
        let rows = initial
            .split(separator: "\n")
            .enumerated()
            .map({ (rowIdx, rows) -> [Cell] in
                rows
                    .compactMap { Int(String($0)) }
                    .enumerated()
                    .map({ (colIdx, given) in
                        return Cell(
                            row: rowIdx,
                            column: colIdx,
                            given: given
                        )
                    })
            })
        let cells = rows.flatMap { $0 }
        self.orderedCells = cells
        self.sortedCells = cells
        self.rows = rows
        
        // Houses for checking
        for i in 0..<9 {
            House.associate(orderedCells, .row) { $0.row == i }
            House.associate(orderedCells, .col) { $0.column == i }
            House.associate(orderedCells, .block) { $0.block == i }
        }
    }
    
    func initialAsString() -> String {
        rows
            .map({ row in
                row
                    .map { cell in cell.given.map(String.init) ?? "0" }
                    .joined()
            })
            .joined(separator: "\n")
    }
    
    public func solve() -> Bool {
//        var loopCount1 = 0
        // Calculate all valid guesses for each cell
        var changed = true
        while changed {
            changed = false
//            loopCount1 += 1
            for cell in sortedCells {
                if cell.calculateValidGuesses() {
                    changed = true
                }
            }
//            for cell in sortedCells {
//                if cell.calculateNakedPairs() {
//                    changed = true
//                }
//            }
            sortedCells.sort { (smaller, larger) in
                guard smaller.needsGuess else { return true }
                return smaller.initialValidGuesses.count <= larger.initialValidGuesses.count
            }
        }
        
//        print("👨🏽‍⚖️", loopCount1,
//              "given:", sortedCells.filter({ $0.given != nil }).count,
//              "solved:", sortedCells.filter({ $0.value != nil }).count)
//        changed = true
//        while changed {
//            changed = false
//            for cell in sortedCells {
//                if cell.calculateNakedPairs() {
//                    changed = true
//                }
//            }
//        }
        
        return solveTheRest(from: 0)
    }
    
    func solveTheRest(from idx81: Int = 0) -> Bool {
        guard idx81 < 81 else { return true }
        let cell = sortedCells[idx81]
        let next = idx81 + 1
        // 1. Is given?
        guard cell.needsGuess else {
            return solveTheRest(from: next)
        }
        
        // 2. Guess, from 1-9 where valid
        for i in cell.initialValidGuesses {
            // Maybe its no longer valid
            guard !cell.housesContain(i) else { continue }
            
            cell.guess = i
            
            let isAllSolved = solveTheRest(from: next)
            
            if isAllSolved {
                // Finished
                return true
            }
            
            // else, this guess did not lead to a valid conclusion, so we try a different guess and do it all again.
        }
        
        // Not solved, so ignore any guesses
        cell.guess = nil
        return false
    }
    
}
