// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CustomerDefaultAddressUpdateMutation: GraphQLMutation {
  public static let operationName: String = "CustomerDefaultAddressUpdate"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CustomerDefaultAddressUpdate($token: String!, $addressId: ID!) { customerDefaultAddressUpdate(customerAccessToken: $token, addressId: $addressId) { __typename customerUserErrors { __typename code field message } } }"#
    ))

  public var token: String
  public var addressId: ID

  public init(
    token: String,
    addressId: ID
  ) {
    self.token = token
    self.addressId = addressId
  }

  public var __variables: Variables? { [
    "token": token,
    "addressId": addressId
  ] }

  public struct Data: MyApi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("customerDefaultAddressUpdate", CustomerDefaultAddressUpdate?.self, arguments: [
        "customerAccessToken": .variable("token"),
        "addressId": .variable("addressId")
      ]),
    ] }

    /// Updates the default address of an existing customer.
    public var customerDefaultAddressUpdate: CustomerDefaultAddressUpdate? { __data["customerDefaultAddressUpdate"] }

    /// CustomerDefaultAddressUpdate
    ///
    /// Parent Type: `CustomerDefaultAddressUpdatePayload`
    public struct CustomerDefaultAddressUpdate: MyApi.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.CustomerDefaultAddressUpdatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("customerUserErrors", [CustomerUserError].self),
      ] }

      /// The list of errors that occurred from executing the mutation.
      public var customerUserErrors: [CustomerUserError] { __data["customerUserErrors"] }

      /// CustomerDefaultAddressUpdate.CustomerUserError
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
