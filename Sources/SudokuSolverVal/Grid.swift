public struct Grid: Equatable, Hashable {
    
    var cells: [Cell]
    
    public init(initial: String) {
        cells = initial
            .split(separator: "\n")
            .enumerated()
            .flatMap({ (rowIdx, rows) -> [Cell] in
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
    }
    
    // MARK: - Logic
    
    public mutating func solve() -> Bool {
        return solveTheRest(from: 0)
    }
    
    mutating func solveTheRest(from idx81: Int) -> Bool {
        guard idx81 < 81 else { return true }
        let cell = cells[idx81]
        let next = idx81 + 1
        
        guard cell.needsGuess else {
            return solveTheRest(from: next)
        }
        
        for i in cell.initialValidGuesses where isValid(i, cell) {
            
            cells[idx81].guess = i
            
            let isAllSolved = solveTheRest(from: next)
            
            if isAllSolved {
                // Finished
                return true
            }
            
            // else, this guess did not lead to a valid conclusion, so we try a different guess and do it all again.
        }
        
        // Not solved, so ignore any guesses
        cells[idx81].guess = nil
        return false
    }
    
    public func isValid(_ i: Int, _ cell: Cell) -> Bool {
        !housesContain(i: i, cell: cell)
    }
    
    private func housesContain(i: Int, cell: Cell) -> Bool {
        return cells.contains { other in
            return other.value == i
                && other.isSameHouse(as: cell)
        }
    }
    
}
