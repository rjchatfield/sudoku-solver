public struct Point: Equatable, CustomDebugStringConvertible {
    public let col: Int
    public let row: Int
    
    public var debugDescription: String { "(col:\(col), row:\(row))" }
    
    public init(col: Int, row: Int) {
        self.col = col
        self.row = row
    }
    
    public func next() -> Point? {
        guard self != .terminate else { return nil }
        let nextCol = (col + 1) % 9
        return Point(
            col: nextCol,
            row: nextCol == 0 ? row + 1 : row
        )
    }
    public static let zero = Point(col: 0, row: 0)
    public static let terminate = Point(col: 8, row: 8)
}
