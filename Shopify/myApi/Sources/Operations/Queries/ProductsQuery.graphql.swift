// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ProductsQuery: GraphQLQuery {
  public static let operationName: String = "ProductsQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query ProductsQuery($query: String!) { products(first: 250, query: $query) { __typename edges { __typename node { __typename availableForSale handle id title totalInventory vendor featuredImage { __typename url } priceRange { __typename maxVariantPrice { __typename amount currencyCode } minVariantPrice { __typename amount currencyCode } } tags } } } }"#
    ))

  public var query: String

  public init(query: String) {
    self.query = query
  }

  public var __variables: Variables? { ["query": query] }

  public struct Data: MyApi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("products", Products.self, arguments: [
        "first": 250,
        "query": .variable("query")
      ]),
    ] }

    /// Returns a list of the shop's products. For storefront search, use the [`search`](https://shopify.dev/docs/api/storefront/latest/queries/search) query.
    public var products: Products { __data["products"] }

    /// Products
    ///
    /// Parent Type: `ProductConnection`
    public struct Products: MyApi.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.ProductConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("edges", [Edge].self),
      ] }

      /// A list of edges.
      public var edges: [Edge] { __data["edges"] }

      /// Products.Edge
      ///
      /// Parent Type: `ProductEdge`
      public struct Edge: MyApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.ProductEdge }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("node", Node.self),
        ] }

        /// The item at the end of ProductEdge.
        public var node: Node { __data["node"] }

        /// Products.Edge.Node
        ///
        /// Parent Type: `Product`
        public struct Node: MyApi.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Product }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("availableForSale", Bool.self),
            .field("handle", String.self),
            .field("id", MyApi.ID.self),
            .field("title", String.self),
            .field("totalInventory", Int?.self),
            .field("vendor", String.self),
            .field("featuredImage", FeaturedImage?.self),
            .field("priceRange", PriceRange.self),
            .field("tags", [String].self),
          ] }

          /// Indicates if at least one product variant is available for sale.
          public var availableForSale: Bool { __data["availableForSale"] }
          /// A unique, human-readable string of the product's title.
          /// A handle can contain letters, hyphens (`-`), and numbers, but no spaces.
          /// The handle is used in the online store URL for the product.
          public var handle: String { __data["handle"] }
          /// A globally-unique ID.
          public var id: MyApi.ID { __data["id"] }
          /// The name for the product that displays to customers. The title is used to construct the product's handle.
          /// For example, if a product is titled "Black Sunglasses", then the handle is `black-sunglasses`.
          public var title: String { __data["title"] }
          /// The quantity of inventory that's in stock.
          public var totalInventory: Int? { __data["totalInventory"] }
          /// The name of the product's vendor.
          public var vendor: String { __data["vendor"] }
          /// The featured image for the product.
          ///
          /// This field is functionally equivalent to `images(first: 1)`.
          public var featuredImage: FeaturedImage? { __data["featuredImage"] }
          /// The minimum and maximum prices of a product, expressed in decimal numbers.
          /// For example, if the product is priced between $10.00 and $50.00,
          /// then the price range is $10.00 - $50.00.
          public var priceRange: PriceRange { __data["priceRange"] }
          /// A comma-separated list of searchable keywords that are
          /// associated with the product. For example, a merchant might apply the `sports`
          /// and `summer` tags to products that are associated with sportwear for summer.
          /// Updating `tags` overwrites any existing tags that were previously added to the product.
          /// To add new tags without overwriting existing tags,
          /// use the GraphQL Admin API's [`tagsAdd`](/docs/api/admin-graphql/latest/mutations/tagsadd)
          /// mutation.
          public var tags: [String] { __data["tags"] }

          /// Products.Edge.Node.FeaturedImage
          ///
          /// Parent Type: `Image`
          public struct FeaturedImage: MyApi.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Image }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("url", MyApi.URL.self),
            ] }

            /// The location of the image as a URL.
            ///
            /// If no transform options are specified, then the original image will be preserved including any pre-applied transforms.
            ///
            /// All transformation options are considered "best-effort". Any transformation that the original image type doesn't support will be ignored.
            ///
            /// If you need multiple variations of the same image, then you can use [GraphQL aliases](https://graphql.org/learn/queries/#aliases).
            public var url: MyApi.URL { __data["url"] }
          }

          /// Products.Edge.Node.PriceRange
          ///
          /// Parent Type: `ProductPriceRange`
          public struct PriceRange: MyApi.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.ProductPriceRange }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("maxVariantPrice", MaxVariantPrice.self),
              .field("minVariantPrice", MinVariantPrice.self),
            ] }

            /// The highest variant's price.
            public var maxVariantPrice: MaxVariantPrice { __data["maxVariantPrice"] }
            /// The lowest variant's price.
            public var minVariantPrice: MinVariantPrice { __data["minVariantPrice"] }

            /// Products.Edge.Node.PriceRange.MaxVariantPrice
            ///
            /// Parent Type: `MoneyV2`
            public struct MaxVariantPrice: MyApi.SelectionSet {
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

            /// Products.Edge.Node.PriceRange.MinVariantPrice
            ///
            /// Parent Type: `MoneyV2`
            public struct MinVariantPrice: MyApi.SelectionSet {
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
