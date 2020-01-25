public struct Cell: Equatable, Hashable {
    
    let row: Int
    let column: Int
    let block: Int
    
    let given: Int?
    let needsGuess: Bool
    var guess: Int? { didSet { value = given ?? guess }}
    /// value = given  ?? guess
    var value: Int?
    
    let initialValidGuesses: Set<Int>
    
    init(row: Int, column: Int, given: Int) {
        self.needsGuess = given == 0
        self.row = row
        self.column = column
        self.block = ((row / 3) * 3) + (column / 3)
        self.given = needsGuess ? nil : given
        self.guess = nil
        self.value = self.given
        self.initialValidGuesses = needsGuess ? .oneToNine : []
    }
    
    func isSameHouse(as other: Cell) -> Bool {
        return row == other.row
            || column == other.column
            || block == other.block
    }
}
