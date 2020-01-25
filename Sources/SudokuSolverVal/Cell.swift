public enum Cell: Equatable, Hashable {
    case given(Int)
    case guess(Int?)
    
    public init?(char: Character) {
        guard let int = Int(String(char)) else { return nil }
        if int != 0 {
            self = .given(int)
        } else {
            self = .guess(nil)
        }
    }
    
    public var value: Int? {
        switch self {
        case .given(let value): return value
        case .guess(let value): return value
        }
    }
}
