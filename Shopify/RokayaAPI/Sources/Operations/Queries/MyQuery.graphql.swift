// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class MyQuery: GraphQLQuery {
  public static let operationName: String = "MyQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query MyQuery { products(first: 10) { __typename edges { __typename cursor node { __typename id title images(first: 10) { __typename edges { __typename node { __typename src width height url } cursor } } } } } }"#
    ))

  public init() {}

  public struct Data: RokayaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("products", Products.self, arguments: ["first": 10]),
    ] }

    /// Returns a list of the shop's products. For storefront search, use the [`search`](https://shopify.dev/docs/api/storefront/latest/queries/search) query.
    public var products: Products { __data["products"] }

    /// Products
    ///
    /// Parent Type: `ProductConnection`
    public struct Products: RokayaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.ProductConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("edges", [Edge].self),
      ] }

      /// A list of edges.
      public var edges: [Edge] { __data["edges"] }

      /// Products.Edge
      ///
      /// Parent Type: `ProductEdge`
      public struct Edge: RokayaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.ProductEdge }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("cursor", String.self),
          .field("node", Node.self),
        ] }

        /// A cursor for use in pagination.
        public var cursor: String { __data["cursor"] }
        /// The item at the end of ProductEdge.
        public var node: Node { __data["node"] }

        /// Products.Edge.Node
        ///
        /// Parent Type: `Product`
        public struct Node: RokayaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.Product }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", RokayaAPI.ID.self),
            .field("title", String.self),
            .field("images", Images.self, arguments: ["first": 10]),
          ] }

          /// A globally-unique ID.
          public var id: RokayaAPI.ID { __data["id"] }
          /// The name for the product that displays to customers. The title is used to construct the product's handle.
          /// For example, if a product is titled "Black Sunglasses", then the handle is `black-sunglasses`.
          public var title: String { __data["title"] }
          /// List of images associated with the product.
          public var images: Images { __data["images"] }

          /// Products.Edge.Node.Images
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

            /// Products.Edge.Node.Images.Edge
            ///
            /// Parent Type: `ImageEdge`
            public struct Edge: RokayaAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.ImageEdge }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("node", Node.self),
                .field("cursor", String.self),
              ] }

              /// The item at the end of ImageEdge.
              public var node: Node { __data["node"] }
              /// A cursor for use in pagination.
              public var cursor: String { __data["cursor"] }

              /// Products.Edge.Node.Images.Edge.Node
              ///
              /// Parent Type: `Image`
              public struct Node: RokayaAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.Image }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("src", RokayaAPI.URL.self),
                  .field("width", Int?.self),
                  .field("height", Int?.self),
                  .field("url", RokayaAPI.URL.self),
                ] }

                /// The location of the image as a URL.
                @available(*, deprecated, message: "Use `url` instead.")
                public var src: RokayaAPI.URL { __data["src"] }
                /// The original width of the image in pixels. Returns `null` if the image isn't hosted by Shopify.
                public var width: Int? { __data["width"] }
                /// The original height of the image in pixels. Returns `null` if the image isn't hosted by Shopify.
                public var height: Int? { __data["height"] }
                /// The location of the image as a URL.
                ///
                /// If no transform options are specified, then the original image will be preserved including any pre-applied transforms.
                ///
                /// All transformation options are considered "best-effort". Any transformation that the original image type doesn't support will be ignored.
                ///
                /// If you need multiple variations of the same image, then you can use [GraphQL aliases](https://graphql.org/learn/queries/#aliases).
                public var url: RokayaAPI.URL { __data["url"] }
              }
            }
          }
        }
      }
    }
  }
}
