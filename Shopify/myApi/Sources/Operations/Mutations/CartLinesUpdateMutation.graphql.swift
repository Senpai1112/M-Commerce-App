// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CartLinesUpdateMutation: GraphQLMutation {
  public static let operationName: String = "CartLinesUpdate"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CartLinesUpdate($cartId: ID!, $lineQuantity: Int!, $lineId: ID!, $merchandiseId: ID!) { cartLinesUpdate( cartId: $cartId lines: { quantity: $lineQuantity, merchandiseId: $merchandiseId, id: $lineId } ) { __typename cart { __typename checkoutUrl createdAt id note totalQuantity updatedAt } userErrors { __typename code field message } } }"#
    ))

  public var cartId: ID
  public var lineQuantity: Int
  public var lineId: ID
  public var merchandiseId: ID

  public init(
    cartId: ID,
    lineQuantity: Int,
    lineId: ID,
    merchandiseId: ID
  ) {
    self.cartId = cartId
    self.lineQuantity = lineQuantity
    self.lineId = lineId
    self.merchandiseId = merchandiseId
  }

  public var __variables: Variables? { [
    "cartId": cartId,
    "lineQuantity": lineQuantity,
    "lineId": lineId,
    "merchandiseId": merchandiseId
  ] }

  public struct Data: MyApi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("cartLinesUpdate", CartLinesUpdate?.self, arguments: [
        "cartId": .variable("cartId"),
        "lines": [
          "quantity": .variable("lineQuantity"),
          "merchandiseId": .variable("merchandiseId"),
          "id": .variable("lineId")
        ]
      ]),
    ] }

    /// Updates one or more merchandise lines on a cart.
    public var cartLinesUpdate: CartLinesUpdate? { __data["cartLinesUpdate"] }

    /// CartLinesUpdate
    ///
    /// Parent Type: `CartLinesUpdatePayload`
    public struct CartLinesUpdate: MyApi.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.CartLinesUpdatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("cart", Cart?.self),
        .field("userErrors", [UserError].self),
      ] }

      /// The updated cart.
      public var cart: Cart? { __data["cart"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// CartLinesUpdate.Cart
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

      /// CartLinesUpdate.UserError
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
