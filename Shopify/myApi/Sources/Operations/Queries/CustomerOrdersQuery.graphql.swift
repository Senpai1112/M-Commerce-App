// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CustomerOrdersQuery: GraphQLQuery {
  public static let operationName: String = "CustomerOrdersQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query CustomerOrdersQuery($token: String!) { customer(customerAccessToken: $token) { __typename orders(first: 10) { __typename totalCount edges { __typename node { __typename cancelReason canceledAt originalTotalPrice { __typename amount currencyCode } processedAt } } } } }"#
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
        .field("orders", Orders.self, arguments: ["first": 10]),
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
              .field("cancelReason", GraphQLEnum<MyApi.OrderCancelReason>?.self),
              .field("canceledAt", MyApi.DateTime?.self),
              .field("originalTotalPrice", OriginalTotalPrice.self),
              .field("processedAt", MyApi.DateTime.self),
            ] }

            /// The reason for the order's cancellation. Returns `null` if the order wasn't canceled.
            public var cancelReason: GraphQLEnum<MyApi.OrderCancelReason>? { __data["cancelReason"] }
            /// The date and time when the order was canceled. Returns null if the order wasn't canceled.
            public var canceledAt: MyApi.DateTime? { __data["canceledAt"] }
            /// The total price of the order before any applied edits.
            public var originalTotalPrice: OriginalTotalPrice { __data["originalTotalPrice"] }
            /// The date and time when the order was imported.
            /// This value can be set to dates in the past when importing from other systems.
            /// If no value is provided, it will be auto-generated based on current date and time.
            public var processedAt: MyApi.DateTime { __data["processedAt"] }

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
          }
        }
      }
    }
  }
}
