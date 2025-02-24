// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CustomerOrdersQuery: GraphQLQuery {
  public static let operationName: String = "CustomerOrdersQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query CustomerOrdersQuery($token: String!) { customer(customerAccessToken: $token) { __typename orders(first: 50) { __typename totalCount edges { __typename node { __typename originalTotalPrice { __typename amount currencyCode } id shippingAddress { __typename address1 country firstName } lineItems(first: 50) { __typename edges { __typename cursor node { __typename quantity title variant { __typename id title image { __typename src } } } } } processedAt email } } } } }"#
    ))

  public var token: String

  public init(token: String) {
    self.token = token
  }

  public var __variables: Variables? { ["token": token] }

  public struct Data: MyApi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("customer", Customer?.self, arguments: ["customerAccessToken": .variable("token")]),
    ] }

    /// The customer associated with the given access token. Tokens are obtained by using the
    /// [`customerAccessTokenCreate` mutation](https://shopify.dev/docs/api/storefront/latest/mutations/customerAccessTokenCreate).
    public var customer: Customer? { __data["customer"] }

    /// Customer
    ///
    /// Parent Type: `Customer`
    public struct Customer: MyApi.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Customer }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("orders", Orders.self, arguments: ["first": 50]),
      ] }

      /// The orders associated with the customer.
      public var orders: Orders { __data["orders"] }

      /// Customer.Orders
      ///
      /// Parent Type: `OrderConnection`
      public struct Orders: MyApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.OrderConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("totalCount", MyApi.UnsignedInt64.self),
          .field("edges", [Edge].self),
        ] }

        /// The total count of Orders.
        public var totalCount: MyApi.UnsignedInt64 { __data["totalCount"] }
        /// A list of edges.
        public var edges: [Edge] { __data["edges"] }

        /// Customer.Orders.Edge
        ///
        /// Parent Type: `OrderEdge`
        public struct Edge: MyApi.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.OrderEdge }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("node", Node.self),
          ] }

          /// The item at the end of OrderEdge.
          public var node: Node { __data["node"] }

          /// Customer.Orders.Edge.Node
          ///
          /// Parent Type: `Order`
          public struct Node: MyApi.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Order }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("originalTotalPrice", OriginalTotalPrice.self),
              .field("id", MyApi.ID.self),
              .field("shippingAddress", ShippingAddress?.self),
              .field("lineItems", LineItems.self, arguments: ["first": 50]),
              .field("processedAt", MyApi.DateTime.self),
              .field("email", String?.self),
            ] }

            /// The total price of the order before any applied edits.
            public var originalTotalPrice: OriginalTotalPrice { __data["originalTotalPrice"] }
            /// A globally-unique ID.
            public var id: MyApi.ID { __data["id"] }
            /// The address to where the order will be shipped.
            public var shippingAddress: ShippingAddress? { __data["shippingAddress"] }
            /// List of the order’s line items.
            public var lineItems: LineItems { __data["lineItems"] }
            /// The date and time when the order was imported.
            /// This value can be set to dates in the past when importing from other systems.
            /// If no value is provided, it will be auto-generated based on current date and time.
            public var processedAt: MyApi.DateTime { __data["processedAt"] }
            /// The customer's email address.
            public var email: String? { __data["email"] }

            /// Customer.Orders.Edge.Node.OriginalTotalPrice
            ///
            /// Parent Type: `MoneyV2`
            public struct OriginalTotalPrice: MyApi.SelectionSet {
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

            /// Customer.Orders.Edge.Node.ShippingAddress
            ///
            /// Parent Type: `MailingAddress`
            public struct ShippingAddress: MyApi.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.MailingAddress }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("address1", String?.self),
                .field("country", String?.self),
                .field("firstName", String?.self),
              ] }

              /// The first line of the address. Typically the street address or PO Box number.
              public var address1: String? { __data["address1"] }
              /// The name of the country.
              public var country: String? { __data["country"] }
              /// The first name of the customer.
              public var firstName: String? { __data["firstName"] }
            }

            /// Customer.Orders.Edge.Node.LineItems
            ///
            /// Parent Type: `OrderLineItemConnection`
            public struct LineItems: MyApi.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.OrderLineItemConnection }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("edges", [Edge].self),
              ] }

              /// A list of edges.
              public var edges: [Edge] { __data["edges"] }

              /// Customer.Orders.Edge.Node.LineItems.Edge
              ///
              /// Parent Type: `OrderLineItemEdge`
              public struct Edge: MyApi.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.OrderLineItemEdge }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("cursor", String.self),
                  .field("node", Node.self),
                ] }

                /// A cursor for use in pagination.
                public var cursor: String { __data["cursor"] }
                /// The item at the end of OrderLineItemEdge.
                public var node: Node { __data["node"] }

                /// Customer.Orders.Edge.Node.LineItems.Edge.Node
                ///
                /// Parent Type: `OrderLineItem`
                public struct Node: MyApi.SelectionSet {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.OrderLineItem }
                  public static var __selections: [ApolloAPI.Selection] { [
                    .field("__typename", String.self),
                    .field("quantity", Int.self),
                    .field("title", String.self),
                    .field("variant", Variant?.self),
                  ] }

                  /// The number of products variants associated to the line item.
                  public var quantity: Int { __data["quantity"] }
                  /// The title of the product combined with title of the variant.
                  public var title: String { __data["title"] }
                  /// The product variant object associated to the line item.
                  public var variant: Variant? { __data["variant"] }

                  /// Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant
                  ///
                  /// Parent Type: `ProductVariant`
                  public struct Variant: MyApi.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.ProductVariant }
                    public static var __selections: [ApolloAPI.Selection] { [
                      .field("__typename", String.self),
                      .field("id", MyApi.ID.self),
                      .field("title", String.self),
                      .field("image", Image?.self),
                    ] }

                    /// A globally-unique ID.
                    public var id: MyApi.ID { __data["id"] }
                    /// The product variant’s title.
                    public var title: String { __data["title"] }
                    /// Image associated with the product variant. This field falls back to the product image if no image is available.
                    public var image: Image? { __data["image"] }

                    /// Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Image
                    ///
                    /// Parent Type: `Image`
                    public struct Image: MyApi.SelectionSet {
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
              }
            }
          }
        }
      }
    }
  }
}
