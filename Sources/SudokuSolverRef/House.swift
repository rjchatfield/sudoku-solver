final class House {
    
    enum Direction {
        case col
        case row
        case block
    }
    
    let cells: [Cell]
    let direction: Direction
    
    init(
        cells: [Cell],
        direction: Direction
    ) {
        self.cells = cells
        self.direction = direction
    }
    
    static func associate(
        _ cells: [Cell],
        _ direction: Direction,
        predicate: (Cell) -> Bool
    ) {
        let house = House(
            // Filter
            cells: cells.filter(predicate),
            direction: direction
        )
        // Link
        for cell in house.cells {
            
            cell.allHouses.append(house)
            
            switch direction {
            case .col: cell.colHouse = house
            case .row: cell.rowHouse = house
            case .block: cell.blockHouse = house
            }
        }
    }
    
    func contains(_ i: Int) -> Bool {
        cells.contains { $0.value == i }
    }
    
}
