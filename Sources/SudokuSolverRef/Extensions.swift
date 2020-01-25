extension Array where Element == Int {
    static let oneToNine = Array(1...9)
}

extension Set where Element == Int {
    public static let oneToNine = Set(Array.oneToNine)
}
