// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ProductDetailsQuery: GraphQLQuery {
  public static let operationName: String = "ProductDetailsQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query ProductDetailsQuery($id: ID!) { product(id: $id) { __typename id title availableForSale description totalInventory images(first: 5) { __typename edges { __typename node { __typename src } } } variants(first: 20) { __typename edges { __typename node { __typename id title priceV2 { __typename amount currencyCode } } } } } }"#
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: MyApi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("product", Product?.self, arguments: ["id": .variable("id")]),
    ] }

    /// Fetch a specific `Product` by one of its unique attributes.
    public var product: Product? { __data["product"] }

    /// Product
    ///
    /// Parent Type: `Product`
    public struct Product: MyApi.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Product }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", MyApi.ID.self),
        .field("title", String.self),
        .field("availableForSale", Bool.self),
        .field("description", String.self),
        .field("totalInventory", Int?.self),
        .field("images", Images.self, arguments: ["first": 5]),
        .field("variants", Variants.self, arguments: ["first": 20]),
      ] }

      /// A globally-unique ID.
      public var id: MyApi.ID { __data["id"] }
      /// The name for the product that displays to customers. The title is used to construct the product's handle.
      /// For example, if a product is titled "Black Sunglasses", then the handle is `black-sunglasses`.
      public var title: String { __data["title"] }
      /// Indicates if at least one product variant is available for sale.
      public var availableForSale: Bool { __data["availableForSale"] }
      /// A single-line description of the product, with [HTML tags](https://developer.mozilla.org/en-US/docs/Web/HTML) removed.
      public var description: String { __data["description"] }
      /// The quantity of inventory that's in stock.
      public var totalInventory: Int? { __data["totalInventory"] }
      /// List of images associated with the product.
      public var images: Images { __data["images"] }
      /// A list of [variants](/docs/api/storefront/latest/objects/ProductVariant) that are associated with the product.
      public var variants: Variants { __data["variants"] }

      /// Product.Images
      ///
      /// Parent Type: `ImageConnection`
      public struct Images: MyApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.ImageConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge].self),
        ] }

        /// A list of edges.
        public var edges: [Edge] { __data["edges"] }

        /// Product.Images.Edge
        ///
        /// Parent Type: `ImageEdge`
        public struct Edge: MyApi.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.ImageEdge }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("node", Node.self),
          ] }

          /// The item at the end of ImageEdge.
          public var node: Node { __data["node"] }

          /// Product.Images.Edge.Node
          ///
          /// Parent Type: `Image`
          public struct Node: MyApi.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Image }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("src", MyApi.URL.self),
            ] }

            /// The location of the image as a URL.
            @available(*, deprecated, message: "Use `url` instead.")
            public var src: MyApi.URL { __data["src"] }
          }
        }
      }

      /// Product.Variants
      ///
      /// Parent Type: `ProductVariantConnection`
      public struct Variants: MyApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.ProductVariantConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge].self),
        ] }

        /// A list of edges.
        public var edges: [Edge] { __data["edges"] }

        /// Product.Variants.Edge
        ///
        /// Parent Type: `ProductVariantEdge`
        public struct Edge: MyApi.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.ProductVariantEdge }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("node", Node.self),
          ] }

          /// The item at the end of ProductVariantEdge.
          public var node: Node { __data["node"] }

          /// Product.Variants.Edge.Node
          ///
          /// Parent Type: `ProductVariant`
          public struct Node: MyApi.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.ProductVariant }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", MyApi.ID.self),
              .field("title", String.self),
              .field("priceV2", PriceV2.self),
            ] }

            /// A globally-unique ID.
            public var id: MyApi.ID { __data["id"] }
            /// The product variant’s title.
            public var title: String { __data["title"] }
            /// The product variant’s price.
            @available(*, deprecated, message: "Use `price` instead.")
            public var priceV2: PriceV2 { __data["priceV2"] }

            /// Product.Variants.Edge.Node.PriceV2
            ///
            /// Parent Type: `MoneyV2`
            public struct PriceV2: MyApi.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.MoneyV2 }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("amount", MyApi.Decimal.self),
                .field("currencyCode", GraphQLEnum<MyApi.CurrencyCode>.self),
              ] }

              /// Decimal money amount.
              public var amount: MyApi.Decimal { __data["amount"] }
              /// Currency of the money.
              public var currencyCode: GraphQLEnum<MyApi.CurrencyCode> { __data["currencyCode"] }
            }
          }
        }
      }
    }
  }
}
