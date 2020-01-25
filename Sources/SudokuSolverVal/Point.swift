public struct Point: Equatable, CustomDebugStringConvertible {
    public let x: Int
    public let y: Int
    
    public var debugDescription: String { "(x:\(x), y:\(y))" }
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    public func next() -> Point? {
        guard self != .terminate else { return nil }
        let nextX = (x + 1) % 9
        return Point(
            x: nextX,
            y: nextX == 0 ? y + 1 : y
        )
    }
    public static let zero = Point(x: 0, y: 0)
    public static let terminate = Point(x: 8, y: 8)
}
