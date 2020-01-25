final class Cell {
    
    let row: Int
    let column: Int
    let block: Int
    
    var value: Int?
    let given: Int?
    var onlyOneValidGuess: Int? { didSet { updateValue() }}
    var guess: Int? { didSet { updateValue() }}
    
    var rowHouse: House!
    var colHouse: House!
    var blockHouse: House!
    var allHouses: [House]
    var initialValidGuesses: [Int]
    var hasCalculatedValidGuesses: Bool = false
    var isInAPair = false
    
    /// Fast enough to stay a computed property
    var needsGuess: Bool { given == nil && onlyOneValidGuess == nil }
    
    public init(row: Int, column: Int, given: Int) {
        self.row = row
        self.column = column
        self.block = ((row / 3) * 3) + (column / 3)
        self.given = (given != 0) ? given : nil
        self.onlyOneValidGuess = nil
        self.guess = nil
        self.rowHouse = nil
        self.colHouse = nil
        self.blockHouse = nil
        self.allHouses = []
        self.initialValidGuesses = []
        updateValue()
    }
    
    func housesContain(_ i: Int) -> Bool {
        allHouses.contains { $0.contains(i) }
    }
    
    /// This was a computed property, but this is faster
    private func updateValue() {
        value = given ?? onlyOneValidGuess ?? guess
    }
    
    /// true if changed
    func calculateValidGuesses() -> Bool {
        // 1. check we dont already have a number
        guard needsGuess else {
//            print("💝 skip")
            return false
        }
//        print("💝...")
        
        // 2. Check each 1...9
        let existing = initialValidGuesses
        initialValidGuesses = Array.oneToNine.filter { i in
            // 2.1 If we've excluded it before, keep excluding it
            if hasCalculatedValidGuesses, !existing.contains(i) {
//                print(" 💝 \(i): we've already excluded it before")
                return false
            }
            // 2.2 If any house already contains it, exclude it
            if housesContain(i) {
//                print(" 💝 \(i): houses contain")
                return false
            }
            // 2.3 Keep it
//            print(" 💝 \(i): keep it")
            return true
        }
        
        /// 3. Optimisation if there is "only 1 valid guess"
        if initialValidGuesses.count == 1 {
            // Only one valid option
            onlyOneValidGuess = initialValidGuesses.first
        } else {
            onlyOneValidGuess = nil
        }
        
        // 4. Toggle a flag
        let firstAttempt = !self.hasCalculatedValidGuesses
        self.hasCalculatedValidGuesses = true
        
        assert(!initialValidGuesses.isEmpty)
        
        // 5. Did something change?
        return firstAttempt
            || initialValidGuesses != existing
    }
    
    // TODO: Use Set<>
    func calculateNakedPairs() -> Bool {
        guard needsGuess, !isInAPair else { return false }
        
        // assume pairs only have 2 values
        guard initialValidGuesses.count == 2 else { return false }
        let pair = initialValidGuesses
        
//        print("🍐 (\(column),\(row))=\(initialValidGuesses)")
//        print(blockHouse.cells
//            .filter { $0 !== self && $0.needsGuess }
//            .map { "   (\($0.column),\($0.row))=\($0.initialValidGuesses)" }
//            .joined(separator: "\n"))
        
        // Iterate over all cells in the same block
        var possibleNakedPairPartner: Cell? = nil
        for sameBlockCell in blockHouse.cells where sameBlockCell !== self && sameBlockCell.needsGuess && sameBlockCell.initialValidGuesses.count == 2 {
            if pair.allSatisfy(sameBlockCell.initialValidGuesses.contains) {
                guard possibleNakedPairPartner == nil else {
//                    print(" 🍐 too many partners = no partner")
                    return false
                }
                possibleNakedPairPartner = sameBlockCell
            }
        }
        
        guard let nakedPairPartner = possibleNakedPairPartner else {
//            print(" 🍐 no partner")
            return false
        }
        
//        print(" 🍐 naked partner 4 lyfe!", "(\(nakedPairPartner.column),\(nakedPairPartner.row))=\(nakedPairPartner.initialValidGuesses)")
        
        // Remove pair from other cells
        var neighbours = blockHouse.cells
        if rowHouse.cells.contains(where: { $0 === nakedPairPartner }) {
            neighbours += rowHouse.cells
        } else if colHouse.cells.contains(where: { $0 === nakedPairPartner }) {
            neighbours += colHouse.cells
        }
        
        for neighbourCell in neighbours where neighbourCell !== self && neighbourCell !== nakedPairPartner && neighbourCell.needsGuess && neighbourCell.initialValidGuesses.contains(where: pair.contains) {
            let oldGuesses = neighbourCell.initialValidGuesses
            neighbourCell.initialValidGuesses.removeAll(where: pair.contains)
//            print("   (\(neighbourCell.column),\(neighbourCell.row))=\(oldGuesses)->\(neighbourCell.initialValidGuesses)")
            if neighbourCell.initialValidGuesses.count == 1 {
//                print("  🍐 SOLVE! 🌅")
                neighbourCell.onlyOneValidGuess = neighbourCell.initialValidGuesses.first
            }
        }
        
        isInAPair = true
        initialValidGuesses = pair
        nakedPairPartner.isInAPair = true
        nakedPairPartner.initialValidGuesses = pair
        
        return true
    }
    
}
