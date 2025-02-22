// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CustomerAddressUpdateMutation: GraphQLMutation {
  public static let operationName: String = "CustomerAddressUpdate"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CustomerAddressUpdate($token: String!, $address1: String!, $address2: String!, $city: String!, $country: String!, $phone: String!, $addressId: ID!) { customerAddressUpdate( customerAccessToken: $token id: $addressId address: { address1: $address1 address2: $address2 city: $city country: $country phone: $phone } ) { __typename customerUserErrors { __typename code field message } customerAddress { __typename address1 address2 city country id phone } } }"#
    ))

  public var token: String
  public var address1: String
  public var address2: String
  public var city: String
  public var country: String
  public var phone: String
  public var addressId: ID

  public init(
    token: String,
    address1: String,
    address2: String,
    city: String,
    country: String,
    phone: String,
    addressId: ID
  ) {
    self.token = token
    self.address1 = address1
    self.address2 = address2
    self.city = city
    self.country = country
    self.phone = phone
    self.addressId = addressId
  }

  public var __variables: Variables? { [
    "token": token,
    "address1": address1,
    "address2": address2,
    "city": city,
    "country": country,
    "phone": phone,
    "addressId": addressId
  ] }

  public struct Data: MyApi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("customerAddressUpdate", CustomerAddressUpdate?.self, arguments: [
        "customerAccessToken": .variable("token"),
        "id": .variable("addressId"),
        "address": [
          "address1": .variable("address1"),
          "address2": .variable("address2"),
          "city": .variable("city"),
          "country": .variable("country"),
          "phone": .variable("phone")
        ]
      ]),
    ] }

    /// Updates the address of an existing customer.
    public var customerAddressUpdate: CustomerAddressUpdate? { __data["customerAddressUpdate"] }

    /// CustomerAddressUpdate
    ///
    /// Parent Type: `CustomerAddressUpdatePayload`
    public struct CustomerAddressUpdate: MyApi.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.CustomerAddressUpdatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("customerUserErrors", [CustomerUserError].self),
        .field("customerAddress", CustomerAddress?.self),
      ] }

      /// The list of errors that occurred from executing the mutation.
      public var customerUserErrors: [CustomerUserError] { __data["customerUserErrors"] }
      /// The customer’s updated mailing address.
      public var customerAddress: CustomerAddress? { __data["customerAddress"] }

      /// CustomerAddressUpdate.CustomerUserError
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

      /// CustomerAddressUpdate.CustomerAddress
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
          .field("city", String?.self),
          .field("country", String?.self),
          .field("id", MyApi.ID.self),
          .field("phone", String?.self),
        ] }

        /// The first line of the address. Typically the street address or PO Box number.
        public var address1: String? { __data["address1"] }
        /// The second line of the address. Typically the number of the apartment, suite, or unit.
        public var address2: String? { __data["address2"] }
        /// The name of the city, district, village, or town.
        public var city: String? { __data["city"] }
        /// The name of the country.
        public var country: String? { __data["country"] }
        /// A globally-unique ID.
        public var id: MyApi.ID { __data["id"] }
        /// A unique phone number for the customer.
        ///
        /// Formatted using E.164 standard. For example, _+16135551111_.
        public var phone: String? { __data["phone"] }
      }
    }
  }
}
