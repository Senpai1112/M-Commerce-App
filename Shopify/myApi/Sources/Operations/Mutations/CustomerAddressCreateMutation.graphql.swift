// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CustomerAddressCreateMutation: GraphQLMutation {
  public static let operationName: String = "CustomerAddressCreate"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CustomerAddressCreate($token: String!, $address1: String!, $address2: String!, $city: String!, $country: String!, $phone: String!) { customerAddressCreate( customerAccessToken: $token address: { address1: $address1 address2: $address2 city: $city country: $country phone: $phone } ) { __typename customerAddress { __typename address1 address2 country phone city id } customerUserErrors { __typename code field message } } }"#
    ))

  public var token: String
  public var address1: String
  public var address2: String
  public var city: String
  public var country: String
  public var phone: String

  public init(
    token: String,
    address1: String,
    address2: String,
    city: String,
    country: String,
    phone: String
  ) {
    self.token = token
    self.address1 = address1
    self.address2 = address2
    self.city = city
    self.country = country
    self.phone = phone
  }

  public var __variables: Variables? { [
    "token": token,
    "address1": address1,
    "address2": address2,
    "city": city,
    "country": country,
    "phone": phone
  ] }

  public struct Data: MyApi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("customerAddressCreate", CustomerAddressCreate?.self, arguments: [
        "customerAccessToken": .variable("token"),
        "address": [
          "address1": .variable("address1"),
          "address2": .variable("address2"),
          "city": .variable("city"),
          "country": .variable("country"),
          "phone": .variable("phone")
        ]
      ]),
    ] }

    /// Creates a new address for a customer.
    public var customerAddressCreate: CustomerAddressCreate? { __data["customerAddressCreate"] }

    /// CustomerAddressCreate
    ///
    /// Parent Type: `CustomerAddressCreatePayload`
    public struct CustomerAddressCreate: MyApi.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.CustomerAddressCreatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("customerAddress", CustomerAddress?.self),
        .field("customerUserErrors", [CustomerUserError].self),
      ] }

      /// The new customer address object.
      public var customerAddress: CustomerAddress? { __data["customerAddress"] }
      /// The list of errors that occurred from executing the mutation.
      public var customerUserErrors: [CustomerUserError] { __data["customerUserErrors"] }

      /// CustomerAddressCreate.CustomerAddress
      ///
      /// Parent Type: `MailingAddress`
      public struct CustomerAddress: MyApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.MailingAddress }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("address1", String?.self),
          .field("address2", String?.self),
          .field("country", String?.self),
          .field("phone", String?.self),
          .field("city", String?.self),
          .field("id", MyApi.ID.self),
        ] }

        /// The first line of the address. Typically the street address or PO Box number.
        public var address1: String? { __data["address1"] }
        /// The second line of the address. Typically the number of the apartment, suite, or unit.
        public var address2: String? { __data["address2"] }
        /// The name of the country.
        public var country: String? { __data["country"] }
        /// A unique phone number for the customer.
        ///
        /// Formatted using E.164 standard. For example, _+16135551111_.
        public var phone: String? { __data["phone"] }
        /// The name of the city, district, village, or town.
        public var city: String? { __data["city"] }
        /// A globally-unique ID.
        public var id: MyApi.ID { __data["id"] }
      }

      /// CustomerAddressCreate.CustomerUserError
      ///
      /// Parent Type: `CustomerUserError`
      public struct CustomerUserError: MyApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.CustomerUserError }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("code", GraphQLEnum<MyApi.CustomerErrorCode>?.self),
          .field("field", [String]?.self),
          .field("message", String.self),
        ] }

        /// The error code.
        public var code: GraphQLEnum<MyApi.CustomerErrorCode>? { __data["code"] }
        /// The path to the input field that caused the error.
        public var field: [String]? { __data["field"] }
        /// The error message.
        public var message: String { __data["message"] }
      }
    }
  }
}
