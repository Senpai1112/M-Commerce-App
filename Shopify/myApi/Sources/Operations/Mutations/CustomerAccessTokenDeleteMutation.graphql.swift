// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CustomerAccessTokenDeleteMutation: GraphQLMutation {
  public static let operationName: String = "CustomerAccessTokenDelete"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CustomerAccessTokenDelete($token: String!) { customerAccessTokenDelete(customerAccessToken: $token) { __typename deletedAccessToken deletedCustomerAccessTokenId userErrors { __typename field message } } }"#
    ))

  public var token: String

  public init(token: String) {
    self.token = token
  }

  public var __variables: Variables? { ["token": token] }

  public struct Data: MyApi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("customerAccessTokenDelete", CustomerAccessTokenDelete?.self, arguments: ["customerAccessToken": .variable("token")]),
    ] }

    /// Permanently destroys a customer access token.
    public var customerAccessTokenDelete: CustomerAccessTokenDelete? { __data["customerAccessTokenDelete"] }

    /// CustomerAccessTokenDelete
    ///
    /// Parent Type: `CustomerAccessTokenDeletePayload`
    public struct CustomerAccessTokenDelete: MyApi.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.CustomerAccessTokenDeletePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("deletedAccessToken", String?.self),
        .field("deletedCustomerAccessTokenId", String?.self),
        .field("userErrors", [UserError].self),
      ] }

      /// The destroyed access token.
      public var deletedAccessToken: String? { __data["deletedAccessToken"] }
      /// ID of the destroyed customer access token.
      public var deletedCustomerAccessTokenId: String? { __data["deletedCustomerAccessTokenId"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// CustomerAccessTokenDelete.UserError
      ///
      /// Parent Type: `UserError`
      public struct UserError: MyApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.UserError }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("field", [String]?.self),
          .field("message", String.self),
        ] }

        /// The path to the input field that caused the error.
        public var field: [String]? { __data["field"] }
        /// The error message.
        public var message: String { __data["message"] }
      }
    }
  }
}
