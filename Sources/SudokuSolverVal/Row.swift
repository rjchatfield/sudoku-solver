public struct Row: Equatable, Hashable {
    public var cells: [Cell] = (0...9).map { _ in .guess(nil) }
}

extension Row {
    init(initial: Substring) {
        cells = initial.compactMap(Cell.init)
    }
}
