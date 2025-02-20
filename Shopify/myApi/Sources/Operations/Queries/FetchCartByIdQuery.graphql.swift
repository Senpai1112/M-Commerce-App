// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class FetchCartByIdQuery: GraphQLQuery {
  public static let operationName: String = "FetchCartById"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query FetchCartById($id: ID!) { cart(id: $id) { __typename checkoutUrl id note totalQuantity updatedAt buyerIdentity { __typename email phone } cost { __typename subtotalAmountEstimated totalAmountEstimated totalDutyAmountEstimated totalTaxAmountEstimated checkoutChargeAmount { __typename amount currencyCode } subtotalAmount { __typename amount currencyCode } totalAmount { __typename amount currencyCode } totalTaxAmount { __typename amount currencyCode } } lines(first: 100) { __typename edges { __typename node { __typename id merchandise { __typename ... on ProductVariant { id quantityAvailable requiresComponents requiresShipping sku taxable title weight weightUnit components(first: 100) { __typename nodes { __typename quantity } } image { __typename url } } } quantity cost { __typename amountPerQuantity { __typename amount currencyCode } totalAmount { __typename amount currencyCode } subtotalAmount { __typename amount currencyCode } } } } } } }"#
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: MyApi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("cart", Cart?.self, arguments: ["id": .variable("id")]),
    ] }

    /// Retrieve a cart by its ID. For more information, refer to
    /// [Manage a cart with the Storefront API](https://shopify.dev/custom-storefronts/cart/manage).
    public var cart: Cart? { __data["cart"] }

    /// Cart
    ///
    /// Parent Type: `Cart`
    public struct Cart: MyApi.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Cart }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("checkoutUrl", MyApi.URL.self),
        .field("id", MyApi.ID.self),
        .field("note", String?.self),
        .field("totalQuantity", Int.self),
        .field("updatedAt", MyApi.DateTime.self),
        .field("buyerIdentity", BuyerIdentity.self),
        .field("cost", Cost.self),
        .field("lines", Lines.self, arguments: ["first": 100]),
      ] }

      /// The URL of the checkout for the cart.
      public var checkoutUrl: MyApi.URL { __data["checkoutUrl"] }
      /// A globally-unique ID.
      public var id: MyApi.ID { __data["id"] }
      /// A note that's associated with the cart. For example, the note can be a personalized message to the buyer.
      public var note: String? { __data["note"] }
      /// The total number of items in the cart.
      public var totalQuantity: Int { __data["totalQuantity"] }
      /// The date and time when the cart was updated.
      public var updatedAt: MyApi.DateTime { __data["updatedAt"] }
      /// Information about the buyer that's interacting with the cart.
      public var buyerIdentity: BuyerIdentity { __data["buyerIdentity"] }
      /// The estimated costs that the buyer will pay at checkout. The costs are subject to change and changes will be reflected at checkout. The `cost` field uses the `buyerIdentity` field to determine [international pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing).
      public var cost: Cost { __data["cost"] }
      /// A list of lines containing information about the items the customer intends to purchase.
      public var lines: Lines { __data["lines"] }

      /// Cart.BuyerIdentity
      ///
      /// Parent Type: `CartBuyerIdentity`
      public struct BuyerIdentity: MyApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.CartBuyerIdentity }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("email", String?.self),
          .field("phone", String?.self),
        ] }

        /// The email address of the buyer that's interacting with the cart.
        public var email: String? { __data["email"] }
        /// The phone number of the buyer that's interacting with the cart.
        public var phone: String? { __data["phone"] }
      }

      /// Cart.Cost
      ///
      /// Parent Type: `CartCost`
      public struct Cost: MyApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.CartCost }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("subtotalAmountEstimated", Bool.self),
          .field("totalAmountEstimated", Bool.self),
          .field("totalDutyAmountEstimated", Bool.self),
          .field("totalTaxAmountEstimated", Bool.self),
          .field("checkoutChargeAmount", CheckoutChargeAmount.self),
          .field("subtotalAmount", SubtotalAmount.self),
          .field("totalAmount", TotalAmount.self),
          .field("totalTaxAmount", TotalTaxAmount?.self),
        ] }

        /// Whether the subtotal amount is estimated.
        public var subtotalAmountEstimated: Bool { __data["subtotalAmountEstimated"] }
        /// Whether the total amount is estimated.
        public var totalAmountEstimated: Bool { __data["totalAmountEstimated"] }
        /// Whether the total duty amount is estimated.
        @available(*, deprecated, message: "Tax and duty amounts are no longer available and will be removed in a future version.\nPlease see [the changelog](https://shopify.dev/changelog/tax-and-duties-are-deprecated-in-storefront-cart-api)\nfor more information.")
        public var totalDutyAmountEstimated: Bool { __data["totalDutyAmountEstimated"] }
        /// Whether the total tax amount is estimated.
        @available(*, deprecated, message: "Tax and duty amounts are no longer available and will be removed in a future version.\nPlease see [the changelog](https://shopify.dev/changelog/tax-and-duties-are-deprecated-in-storefront-cart-api)\nfor more information.")
        public var totalTaxAmountEstimated: Bool { __data["totalTaxAmountEstimated"] }
        /// The estimated amount, before taxes and discounts, for the customer to pay at checkout. The checkout charge amount doesn't include any deferred payments that'll be paid at a later date. If the cart has no deferred payments, then the checkout charge amount is equivalent to `subtotalAmount`.
        public var checkoutChargeAmount: CheckoutChargeAmount { __data["checkoutChargeAmount"] }
        /// The amount, before taxes and cart-level discounts, for the customer to pay.
        public var subtotalAmount: SubtotalAmount { __data["subtotalAmount"] }
        /// The total amount for the customer to pay.
        public var totalAmount: TotalAmount { __data["totalAmount"] }
        /// The tax amount for the customer to pay at checkout.
        @available(*, deprecated, message: "Tax and duty amounts are no longer available and will be removed in a future version.\nPlease see [the changelog](https://shopify.dev/changelog/tax-and-duties-are-deprecated-in-storefront-cart-api)\nfor more information.")
        public var totalTaxAmount: TotalTaxAmount? { __data["totalTaxAmount"] }

        /// Cart.Cost.CheckoutChargeAmount
        ///
        /// Parent Type: `MoneyV2`
        public struct CheckoutChargeAmount: MyApi.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.MoneyV2 }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("amount", MyApi.Decimal.self),
            .field("currencyCode", GraphQLEnum<MyApi.CurrencyCode>.self),
          ] }

          /// Decimal money amount.
          public var amount: MyApi.Decimal { __data["amount"] }
          /// Currency of the money.
          public var currencyCode: GraphQLEnum<MyApi.CurrencyCode> { __data["currencyCode"] }
        }

        /// Cart.Cost.SubtotalAmount
        ///
        /// Parent Type: `MoneyV2`
        public struct SubtotalAmount: MyApi.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.MoneyV2 }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("amount", MyApi.Decimal.self),
            .field("currencyCode", GraphQLEnum<MyApi.CurrencyCode>.self),
          ] }

          /// Decimal money amount.
          public var amount: MyApi.Decimal { __data["amount"] }
          /// Currency of the money.
          public var currencyCode: GraphQLEnum<MyApi.CurrencyCode> { __data["currencyCode"] }
        }

        /// Cart.Cost.TotalAmount
        ///
        /// Parent Type: `MoneyV2`
        public struct TotalAmount: MyApi.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.MoneyV2 }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("amount", MyApi.Decimal.self),
            .field("currencyCode", GraphQLEnum<MyApi.CurrencyCode>.self),
          ] }

          /// Decimal money amount.
          public var amount: MyApi.Decimal { __data["amount"] }
          /// Currency of the money.
          public var currencyCode: GraphQLEnum<MyApi.CurrencyCode> { __data["currencyCode"] }
        }

        /// Cart.Cost.TotalTaxAmount
        ///
        /// Parent Type: `MoneyV2`
        public struct TotalTaxAmount: MyApi.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.MoneyV2 }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("amount", MyApi.Decimal.self),
            .field("currencyCode", GraphQLEnum<MyApi.CurrencyCode>.self),
          ] }

          /// Decimal money amount.
          public var amount: MyApi.Decimal { __data["amount"] }
          /// Currency of the money.
          public var currencyCode: GraphQLEnum<MyApi.CurrencyCode> { __data["currencyCode"] }
        }
      }

      /// Cart.Lines
      ///
      /// Parent Type: `BaseCartLineConnection`
      public struct Lines: MyApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.BaseCartLineConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge].self),
        ] }

        /// A list of edges.
        public var edges: [Edge] { __data["edges"] }

        /// Cart.Lines.Edge
        ///
        /// Parent Type: `BaseCartLineEdge`
        public struct Edge: MyApi.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.BaseCartLineEdge }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("node", Node.self),
          ] }

          /// The item at the end of BaseCartLineEdge.
          public var node: Node { __data["node"] }

          /// Cart.Lines.Edge.Node
          ///
          /// Parent Type: `BaseCartLine`
          public struct Node: MyApi.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { MyApi.Interfaces.BaseCartLine }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", MyApi.ID.self),
              .field("merchandise", Merchandise.self),
              .field("quantity", Int.self),
              .field("cost", Cost.self),
            ] }

            /// A globally-unique ID.
            public var id: MyApi.ID { __data["id"] }
            /// The merchandise that the buyer intends to purchase.
            public var merchandise: Merchandise { __data["merchandise"] }
            /// The quantity of the merchandise that the customer intends to purchase.
            public var quantity: Int { __data["quantity"] }
            /// The cost of the merchandise that the buyer will pay for at checkout. The costs are subject to change and changes will be reflected at checkout.
            public var cost: Cost { __data["cost"] }

            /// Cart.Lines.Edge.Node.Merchandise
            ///
            /// Parent Type: `Merchandise`
            public struct Merchandise: MyApi.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: any ApolloAPI.ParentType { MyApi.Unions.Merchandise }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .inlineFragment(AsProductVariant.self),
              ] }

              public var asProductVariant: AsProductVariant? { _asInlineFragment() }

              /// Cart.Lines.Edge.Node.Merchandise.AsProductVariant
              ///
              /// Parent Type: `ProductVariant`
              public struct AsProductVariant: MyApi.InlineFragment {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public typealias RootEntityType = FetchCartByIdQuery.Data.Cart.Lines.Edge.Node.Merchandise
                public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.ProductVariant }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("id", MyApi.ID.self),
                  .field("quantityAvailable", Int?.self),
                  .field("requiresComponents", Bool.self),
                  .field("requiresShipping", Bool.self),
                  .field("sku", String?.self),
                  .field("taxable", Bool.self),
                  .field("title", String.self),
                  .field("weight", Double?.self),
                  .field("weightUnit", GraphQLEnum<MyApi.WeightUnit>.self),
                  .field("components", Components.self, arguments: ["first": 100]),
                  .field("image", Image?.self),
                ] }

                /// A globally-unique ID.
                public var id: MyApi.ID { __data["id"] }
                /// The total sellable quantity of the variant for online sales channels.
                public var quantityAvailable: Int? { __data["quantityAvailable"] }
                /// Whether a product variant requires components. The default value is `false`.
                /// If `true`, then the product variant can only be purchased as a parent bundle with components.
                public var requiresComponents: Bool { __data["requiresComponents"] }
                /// Whether a customer needs to provide a shipping address when placing an order for the product variant.
                public var requiresShipping: Bool { __data["requiresShipping"] }
                /// The SKU (stock keeping unit) associated with the variant.
                public var sku: String? { __data["sku"] }
                /// Whether tax is charged when the product variant is sold.
                public var taxable: Bool { __data["taxable"] }
                /// The product variant’s title.
                public var title: String { __data["title"] }
                /// The weight of the product variant in the unit system specified with `weight_unit`.
                public var weight: Double? { __data["weight"] }
                /// Unit of measurement for weight.
                public var weightUnit: GraphQLEnum<MyApi.WeightUnit> { __data["weightUnit"] }
                /// List of bundles components included in the variant considering only fixed bundles.
                public var components: Components { __data["components"] }
                /// Image associated with the product variant. This field falls back to the product image if no image is available.
                public var image: Image? { __data["image"] }

                /// Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Components
                ///
                /// Parent Type: `ProductVariantComponentConnection`
                public struct Components: MyApi.SelectionSet {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.ProductVariantComponentConnection }
                  public static var __selections: [ApolloAPI.Selection] { [
                    .field("__typename", String.self),
                    .field("nodes", [Node].self),
                  ] }

                  /// A list of the nodes contained in ProductVariantComponentEdge.
                  public var nodes: [Node] { __data["nodes"] }

                  /// Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Components.Node
                  ///
                  /// Parent Type: `ProductVariantComponent`
                  public struct Node: MyApi.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.ProductVariantComponent }
                    public static var __selections: [ApolloAPI.Selection] { [
                      .field("__typename", String.self),
                      .field("quantity", Int.self),
                    ] }

                    /// The quantity of component present in the bundle.
                    public var quantity: Int { __data["quantity"] }
                  }
                }

                /// Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image
                ///
                /// Parent Type: `Image`
                public struct Image: MyApi.SelectionSet {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.Image }
                  public static var __selections: [ApolloAPI.Selection] { [
                    .field("__typename", String.self),
                    .field("url", MyApi.URL.self),
                  ] }

                  /// The location of the image as a URL.
                  ///
                  /// If no transform options are specified, then the original image will be preserved including any pre-applied transforms.
                  ///
                  /// All transformation options are considered "best-effort". Any transformation that the original image type doesn't support will be ignored.
                  ///
                  /// If you need multiple variations of the same image, then you can use [GraphQL aliases](https://graphql.org/learn/queries/#aliases).
                  public var url: MyApi.URL { __data["url"] }
                }
              }
            }

            /// Cart.Lines.Edge.Node.Cost
            ///
            /// Parent Type: `CartLineCost`
            public struct Cost: MyApi.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.CartLineCost }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("amountPerQuantity", AmountPerQuantity.self),
                .field("totalAmount", TotalAmount.self),
                .field("subtotalAmount", SubtotalAmount.self),
              ] }

              /// The amount of the merchandise line.
              public var amountPerQuantity: AmountPerQuantity { __data["amountPerQuantity"] }
              /// The total cost of the merchandise line.
              public var totalAmount: TotalAmount { __data["totalAmount"] }
              /// The cost of the merchandise line before line-level discounts.
              public var subtotalAmount: SubtotalAmount { __data["subtotalAmount"] }

              /// Cart.Lines.Edge.Node.Cost.AmountPerQuantity
              ///
              /// Parent Type: `MoneyV2`
              public struct AmountPerQuantity: MyApi.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.MoneyV2 }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("amount", MyApi.Decimal.self),
                  .field("currencyCode", GraphQLEnum<MyApi.CurrencyCode>.self),
                ] }

                /// Decimal money amount.
                public var amount: MyApi.Decimal { __data["amount"] }
                /// Currency of the money.
                public var currencyCode: GraphQLEnum<MyApi.CurrencyCode> { __data["currencyCode"] }
              }

              /// Cart.Lines.Edge.Node.Cost.TotalAmount
              ///
              /// Parent Type: `MoneyV2`
              public struct TotalAmount: MyApi.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.MoneyV2 }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("amount", MyApi.Decimal.self),
                  .field("currencyCode", GraphQLEnum<MyApi.CurrencyCode>.self),
                ] }

                /// Decimal money amount.
                public var amount: MyApi.Decimal { __data["amount"] }
                /// Currency of the money.
                public var currencyCode: GraphQLEnum<MyApi.CurrencyCode> { __data["currencyCode"] }
              }

              /// Cart.Lines.Edge.Node.Cost.SubtotalAmount
              ///
              /// Parent Type: `MoneyV2`
              public struct SubtotalAmount: MyApi.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: any ApolloAPI.ParentType { MyApi.Objects.MoneyV2 }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("amount", MyApi.Decimal.self),
                  .field("currencyCode", GraphQLEnum<MyApi.CurrencyCode>.self),
                ] }

                /// Decimal money amount.
                public var amount: MyApi.Decimal { __data["amount"] }
                /// Currency of the money.
                public var currencyCode: GraphQLEnum<MyApi.CurrencyCode> { __data["currencyCode"] }
              }
            }
          }
        }
      }
    }
  }
}
