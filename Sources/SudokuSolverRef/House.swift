final class House {
    
    enum Direction {
        case col
        case row
        case block
    }
    
    let cells: [Cell]
    let direction: Direction
    
    init(
        _ cells: [Cell],
        _ direction: Direction,
        predicate: (Cell) -> Bool
    ) {
        // Filter
        self.cells = cells.filter(predicate)
        self.direction = direction
        // Link
        for cell in self.cells {
            
            cell.allHouses.append(self)
            
            switch direction {
            case .col: cell.colHouse = self
            case .row: cell.rowHouse = self
            case .block: cell.blockHouse = self
            }
        }
    }
    
    func contains(_ i: Int) -> Bool {
        cells.contains { $0.value == i }
    }
}
