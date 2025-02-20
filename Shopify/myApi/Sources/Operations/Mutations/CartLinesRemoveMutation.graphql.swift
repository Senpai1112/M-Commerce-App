// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CartLinesRemoveMutation: GraphQLMutation {
  public static let operationName: String = "CartLinesRemove"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CartLinesRemove($cartId: ID!, $linesIds: [ID!]!) { cartLinesRemove(cartId: $cartId, lineIds: $linesIds) { __typename userErrors { __typename code field message } } }"#
    ))

  public var cartId: ID
  public var linesIds: [ID]

  public init(
    cartId: ID,
    linesIds: [ID]
  ) {
    self.cartId = cartId
    self.linesIds = linesIds
  }

  public var __variables: Variables? { [
    "cartId": cartId,
    "linesIds": linesIds
  ] }

  public struct Data: MyApi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("cartLinesRemove", CartLinesRemove?.self, arguments: [
        "cartId": .variable("cartId"),
        "lineIds": .variable("linesIds")
      ]),
    ] }

    /// Removes one or more merchandise lines from the cart.
    public var cartLinesRemove: CartLinesRemove? { __data["cartLinesRemove"] }

    /// CartLinesRemove
    ///
    /// Parent Type: `CartLinesRemovePayload`
    public struct CartLinesRemove: MyApi.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.CartLinesRemovePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("userErrors", [UserError].self),
      ] }

      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// CartLinesRemove.UserError
      ///
      /// Parent Type: `CartUserError`
      public struct UserError: MyApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.CartUserError }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("code", GraphQLEnum<MyApi.CartErrorCode>?.self),
          .field("field", [String]?.self),
          .field("message", String.self),
        ] }

        /// The error code.
        public var code: GraphQLEnum<MyApi.CartErrorCode>? { __data["code"] }
        /// The path to the input field that caused the error.
        public var field: [String]? { __data["field"] }
        /// The error message.
        public var message: String { __data["message"] }
      }
    }
  }
}
