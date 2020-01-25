public final class Grid {
    
    let orderedCells: [Cell]
    var sortedCells: [Cell]
    let houses: [House]
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
        houses = (0..<9).flatMap { i -> [House] in
            [
                House(cells, .row) { $0.row == i },
                House(cells, .col) { $0.column == i },
                House(cells, .block) { $0.block == i },
            ]
        }
        
        // Calculate all valid guesses for each cell
        var changed = true
        while changed {
            changed = false
            for cell in self.sortedCells {
                if cell.calculateValidGuesses() {
                    changed = true
                }
            }
            for cell in self.sortedCells {
                if cell.calculateNakedPairs() {
                    changed = true
                }
            }
            sortedCells.sort {
                $0.initialValidGuesses.count < $1.initialValidGuesses.count
            }
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
    
    public func solveTheRest(from idx81: Int = 0) -> Bool {
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
