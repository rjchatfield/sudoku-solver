final class House {
    
    let cells: [Cell]
    
    init(_ cells: [Cell], predicate: (Cell) -> Bool) {
        // Filter
        self.cells = cells.filter(predicate)
        // Link
        for cell in self.cells {
            cell.houses.append(self)
        }
    }
    
    func contains(_ i: Int) -> Bool {
        cells.contains { $0.value == i }
    }
}
