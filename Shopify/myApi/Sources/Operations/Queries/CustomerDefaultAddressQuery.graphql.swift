// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CustomerDefaultAddressQuery: GraphQLQuery {
  public static let operationName: String = "CustomerDefaultAddress"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query CustomerDefaultAddress($token: String!) { customer(customerAccessToken: $token) { __typename defaultAddress { __typename address1 address2 city country phone id countryCode } } }"#
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
        .field("defaultAddress", DefaultAddress?.self),
      ] }

      /// The customer’s default address.
      public var defaultAddress: DefaultAddress? { __data["defaultAddress"] }

      /// Customer.DefaultAddress
      ///
      /// Parent Type: `MailingAddress`
      public struct DefaultAddress: MyApi.SelectionSet {
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
          .field("countryCode", String?.self),
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
        /// The two-letter code for the country of the address.
        ///
        /// For example, US.
        @available(*, deprecated, message: "Use `countryCodeV2` instead.")
        public var countryCode: String? { __data["countryCode"] }
      }
    }
  }
}
