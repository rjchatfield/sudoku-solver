final class Cell {
    
    let row: Int
    let column: Int
    let section: Int
    
    var value: Int?
    let given: Int?
    var onlyOneValidGuess: Int? { didSet { updateValue() }}
    var guess: Int? { didSet { updateValue() }}
    
    var houses: [House]
    var initialValidGuesses: [Int]
    var hasCalculatedValidGuesses: Bool = false
    
    /// Fast enough to stay a computed property
    var needsGuess: Bool { given == nil && onlyOneValidGuess == nil }
    
    public init(row: Int, column: Int, given: Int) {
        self.row = row
        self.column = column
        self.section = ((row / 3) * 3) + (column / 3)
        self.given = (given != 0) ? given : nil
        self.onlyOneValidGuess = nil
        self.guess = nil
        self.houses = []
        self.initialValidGuesses = []
        updateValue()
    }
    
    func housesContain(_ i: Int) -> Bool {
        houses.contains { $0.contains(i) }
    }
    
    /// This was a computed property, but this is faster
    private func updateValue() {
        value = given ?? onlyOneValidGuess ?? guess
    }
    
    /// true if changed
    func calculateValidGuesses() -> Bool {
        // 1. check we dont already have a number
        guard needsGuess else {
            return false
        }
        
        // 2. Check each 1...9
        let existing = initialValidGuesses
        initialValidGuesses = Array.oneToNine.filter { i in
            // 2.1 If we've excluded it before, keep excluding it
            if hasCalculatedValidGuesses, !existing.contains(i) { return false }
            // 2.2 If any house already contains it, exclude it
            if housesContain(i) { return false }
            // 2.3 Keep it
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
        
        // 5. Did something change?
        return firstAttempt
            || initialValidGuesses != existing
    }
    
}
