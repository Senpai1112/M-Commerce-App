// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CustomerAddressesQuery: GraphQLQuery {
  public static let operationName: String = "CustomerAddresses"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query CustomerAddresses($token: String!) { customer(customerAccessToken: $token) { __typename addresses(first: 10) { __typename edges { __typename cursor node { __typename address1 address2 city country phone id } } } } }"#
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
        .field("addresses", Addresses.self, arguments: ["first": 10]),
      ] }

      /// A list of addresses for the customer.
      public var addresses: Addresses { __data["addresses"] }

      /// Customer.Addresses
      ///
      /// Parent Type: `MailingAddressConnection`
      public struct Addresses: MyApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.MailingAddressConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge].self),
        ] }

        /// A list of edges.
        public var edges: [Edge] { __data["edges"] }

        /// Customer.Addresses.Edge
        ///
        /// Parent Type: `MailingAddressEdge`
        public struct Edge: MyApi.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.MailingAddressEdge }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("cursor", String.self),
            .field("node", Node.self),
          ] }

          /// A cursor for use in pagination.
          public var cursor: String { __data["cursor"] }
          /// The item at the end of MailingAddressEdge.
          public var node: Node { __data["node"] }

          /// Customer.Addresses.Edge.Node
          ///
          /// Parent Type: `MailingAddress`
          public struct Node: MyApi.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.MailingAddress }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("address1", String?.self),
              .field("address2", String?.self),
              .field("city", String?.self),
              .field("country", String?.self),
              .field("phone", String?.self),
              .field("id", MyApi.ID.self),
            ] }

            /// The first line of the address. Typically the street address or PO Box number.
            public var address1: String? { __data["address1"] }
            /// The second line of the address. Typically the number of the apartment, suite, or unit.
            public var address2: String? { __data["address2"] }
            /// The name of the city, district, village, or town.
            public var city: String? { __data["city"] }
            /// The name of the country.
            public var country: String? { __data["country"] }
            /// A unique phone number for the customer.
            ///
            /// Formatted using E.164 standard. For example, _+16135551111_.
            public var phone: String? { __data["phone"] }
            /// A globally-unique ID.
            public var id: MyApi.ID { __data["id"] }
          }
        }
      }
    }
  }
}
