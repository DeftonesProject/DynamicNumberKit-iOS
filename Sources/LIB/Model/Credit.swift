
public struct Credit: Equatable {
    public var amount: Int
    public var frozen: Int

    public init(amount: Int, frozen: Int) {
        self.amount = amount
        self.frozen = frozen
    }
}
