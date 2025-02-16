// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ProductDetailsQuery: GraphQLQuery {
  public static let operationName: String = "ProductDetailsQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query ProductDetailsQuery($id: ID!) { product(id: $id) { __typename availableForSale description id title totalInventory images(first: 5) { __typename edges { __typename node { __typename src } } } adjacentVariants { __typename price { __typename amount currencyCode } } } }"#
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: RokayaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("product", Product?.self, arguments: ["id": .variable("id")]),
    ] }

    /// Fetch a specific `Product` by one of its unique attributes.
    public var product: Product? { __data["product"] }

    /// Product
    ///
    /// Parent Type: `Product`
    public struct Product: RokayaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.Product }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("availableForSale", Bool.self),
        .field("description", String.self),
        .field("id", RokayaAPI.ID.self),
        .field("title", String.self),
        .field("totalInventory", Int?.self),
        .field("images", Images.self, arguments: ["first": 5]),
        .field("adjacentVariants", [AdjacentVariant].self),
      ] }

      /// Indicates if at least one product variant is available for sale.
      public var availableForSale: Bool { __data["availableForSale"] }
      /// A single-line description of the product, with [HTML tags](https://developer.mozilla.org/en-US/docs/Web/HTML) removed.
      public var description: String { __data["description"] }
      /// A globally-unique ID.
      public var id: RokayaAPI.ID { __data["id"] }
      /// The name for the product that displays to customers. The title is used to construct the product's handle.
      /// For example, if a product is titled "Black Sunglasses", then the handle is `black-sunglasses`.
      public var title: String { __data["title"] }
      /// The quantity of inventory that's in stock.
      public var totalInventory: Int? { __data["totalInventory"] }
      /// List of images associated with the product.
      public var images: Images { __data["images"] }
      /// A list of variants whose selected options differ with the provided selected options by one, ordered by variant id.
      /// If selected options are not provided, adjacent variants to the first available variant is returned.
      ///
      /// Note that this field returns an array of variants. In most cases, the number of variants in this array will be low.
      /// However, with a low number of options and a high number of values per option, the number of variants returned
      /// here can be high. In such cases, it recommended to avoid using this field.
      ///
      /// This list of variants can be used in combination with the `options` field to build a rich variant picker that
      /// includes variant availability or other variant information.
      public var adjacentVariants: [AdjacentVariant] { __data["adjacentVariants"] }

      /// Product.Images
      ///
      /// Parent Type: `ImageConnection`
      public struct Images: RokayaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.ImageConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge].self),
        ] }

        /// A list of edges.
        public var edges: [Edge] { __data["edges"] }

        /// Product.Images.Edge
        ///
        /// Parent Type: `ImageEdge`
        public struct Edge: RokayaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.ImageEdge }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("node", Node.self),
          ] }

          /// The item at the end of ImageEdge.
          public var node: Node { __data["node"] }

          /// Product.Images.Edge.Node
          ///
          /// Parent Type: `Image`
          public struct Node: RokayaAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.Image }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("src", RokayaAPI.URL.self),
            ] }

            /// The location of the image as a URL.
            @available(*, deprecated, message: "Use `url` instead.")
            public var src: RokayaAPI.URL { __data["src"] }
          }
        }
      }

      /// Product.AdjacentVariant
      ///
      /// Parent Type: `ProductVariant`
      public struct AdjacentVariant: RokayaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.ProductVariant }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("price", Price.self),
        ] }

        /// The product variant’s price.
        public var price: Price { __data["price"] }

        /// Product.AdjacentVariant.Price
        ///
        /// Parent Type: `MoneyV2`
        public struct Price: RokayaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.MoneyV2 }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("amount", RokayaAPI.Decimal.self),
            .field("currencyCode", GraphQLEnum<RokayaAPI.CurrencyCode>.self),
          ] }

          /// Decimal money amount.
          public var amount: RokayaAPI.Decimal { __data["amount"] }
          /// Currency of the money.
          public var currencyCode: GraphQLEnum<RokayaAPI.CurrencyCode> { __data["currencyCode"] }
        }
      }
    }
  }
}
