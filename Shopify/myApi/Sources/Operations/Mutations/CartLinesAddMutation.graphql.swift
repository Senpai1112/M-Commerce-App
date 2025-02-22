// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CartLinesAddMutation: GraphQLMutation {
  public static let operationName: String = "CartLinesAdd"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CartLinesAdd($cartId: ID!, $lines: [CartLineInput!]!) { cartLinesAdd(cartId: $cartId, lines: $lines) { __typename cart { __typename checkoutUrl createdAt id note totalQuantity updatedAt } userErrors { __typename code field message } } }"#
    ))

  public var cartId: ID
  public var lines: [CartLineInput]

  public init(
    cartId: ID,
    lines: [CartLineInput]
  ) {
    self.cartId = cartId
    self.lines = lines
  }

  public var __variables: Variables? { [
    "cartId": cartId,
    "lines": lines
  ] }

  public struct Data: MyApi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("cartLinesAdd", CartLinesAdd?.self, arguments: [
        "cartId": .variable("cartId"),
        "lines": .variable("lines")
      ]),
    ] }

    /// Adds a merchandise line to the cart.
    public var cartLinesAdd: CartLinesAdd? { __data["cartLinesAdd"] }

    /// CartLinesAdd
    ///
    /// Parent Type: `CartLinesAddPayload`
    public struct CartLinesAdd: MyApi.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.CartLinesAddPayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("cart", Cart?.self),
        .field("userErrors", [UserError].self),
      ] }

      /// The updated cart.
      public var cart: Cart? { __data["cart"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// CartLinesAdd.Cart
      ///
      /// Parent Type: `Cart`
      public struct Cart: MyApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Cart }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("checkoutUrl", MyApi.URL.self),
          .field("createdAt", MyApi.DateTime.self),
          .field("id", MyApi.ID.self),
          .field("note", String?.self),
          .field("totalQuantity", Int.self),
          .field("updatedAt", MyApi.DateTime.self),
        ] }

        /// The URL of the checkout for the cart.
        public var checkoutUrl: MyApi.URL { __data["checkoutUrl"] }
        /// The date and time when the cart was created.
        public var createdAt: MyApi.DateTime { __data["createdAt"] }
        /// A globally-unique ID.
        public var id: MyApi.ID { __data["id"] }
        /// A note that's associated with the cart. For example, the note can be a personalized message to the buyer.
        public var note: String? { __data["note"] }
        /// The total number of items in the cart.
        public var totalQuantity: Int { __data["totalQuantity"] }
        /// The date and time when the cart was updated.
        public var updatedAt: MyApi.DateTime { __data["updatedAt"] }
      }

      /// CartLinesAdd.UserError
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
