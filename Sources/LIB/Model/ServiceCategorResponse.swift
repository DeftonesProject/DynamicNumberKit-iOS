public struct ServiceCategoryResponse: Decodable {
    public var categories: [CategoryModel]
}

public struct CategoryModel: Decodable {
    public let id: String
    public let title: String
}
