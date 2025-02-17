// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CustomerAccessTokenCreateMutation: GraphQLMutation {
  public static let operationName: String = "CustomerAccessTokenCreateMutation"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CustomerAccessTokenCreateMutation($email: String!, $password: String!) { customerAccessTokenCreate(input: { email: $email, password: $password }) { __typename customerAccessToken { __typename accessToken } customerUserErrors { __typename code field message } } }"#
    ))

  public var email: String
  public var password: String

  public init(
    email: String,
    password: String
  ) {
    self.email = email
    self.password = password
  }

  public var __variables: Variables? { [
    "email": email,
    "password": password
  ] }

  public struct Data: RokayaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("customerAccessTokenCreate", CustomerAccessTokenCreate?.self, arguments: ["input": [
        "email": .variable("email"),
        "password": .variable("password")
      ]]),
    ] }

    /// Creates a customer access token.
    /// The customer access token is required to modify the customer object in any way.
    public var customerAccessTokenCreate: CustomerAccessTokenCreate? { __data["customerAccessTokenCreate"] }

    /// CustomerAccessTokenCreate
    ///
    /// Parent Type: `CustomerAccessTokenCreatePayload`
    public struct CustomerAccessTokenCreate: RokayaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.CustomerAccessTokenCreatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("customerAccessToken", CustomerAccessToken?.self),
        .field("customerUserErrors", [CustomerUserError].self),
      ] }

      /// The newly created customer access token object.
      public var customerAccessToken: CustomerAccessToken? { __data["customerAccessToken"] }
      /// The list of errors that occurred from executing the mutation.
      public var customerUserErrors: [CustomerUserError] { __data["customerUserErrors"] }

      /// CustomerAccessTokenCreate.CustomerAccessToken
      ///
      /// Parent Type: `CustomerAccessToken`
      public struct CustomerAccessToken: RokayaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.CustomerAccessToken }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("accessToken", String.self),
        ] }

        /// The customer’s access token.
        public var accessToken: String { __data["accessToken"] }
      }

      /// CustomerAccessTokenCreate.CustomerUserError
      ///
      /// Parent Type: `CustomerUserError`
      public struct CustomerUserError: RokayaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.CustomerUserError }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("code", GraphQLEnum<RokayaAPI.CustomerErrorCode>?.self),
          .field("field", [String]?.self),
          .field("message", String.self),
        ] }

        /// The error code.
        public var code: GraphQLEnum<RokayaAPI.CustomerErrorCode>? { __data["code"] }
        /// The path to the input field that caused the error.
        public var field: [String]? { __data["field"] }
        /// The error message.
        public var message: String { __data["message"] }
      }
    }
  }
}
