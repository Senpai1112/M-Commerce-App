// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetCustomerDetailsQuery: GraphQLQuery {
  public static let operationName: String = "GetCustomerDetails"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetCustomerDetails($token: String!) { customer(customerAccessToken: $token) { __typename displayName email firstName id lastName phone } }"#
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
        .field("displayName", String.self),
        .field("email", String?.self),
        .field("firstName", String?.self),
        .field("id", MyApi.ID.self),
        .field("lastName", String?.self),
        .field("phone", String?.self),
      ] }

      /// The customer’s name, email or phone number.
      public var displayName: String { __data["displayName"] }
      /// The customer’s email address.
      public var email: String? { __data["email"] }
      /// The customer’s first name.
      public var firstName: String? { __data["firstName"] }
      /// A unique ID for the customer.
      public var id: MyApi.ID { __data["id"] }
      /// The customer’s last name.
      public var lastName: String? { __data["lastName"] }
      /// The customer’s phone number.
      public var phone: String? { __data["phone"] }
    }
  }
}
