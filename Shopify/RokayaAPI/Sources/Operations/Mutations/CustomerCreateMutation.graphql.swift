// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CustomerCreateMutation: GraphQLMutation {
  public static let operationName: String = "CustomerCreateMutation"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CustomerCreateMutation($firstName: String!, $lastName: String!, $email: String!, $password: String!) { customerCreate( input: { firstName: $firstName lastName: $lastName email: $email password: $password } ) { __typename customer { __typename email firstName id lastName } customerUserErrors { __typename code field message } } }"#
    ))

  public var firstName: String
  public var lastName: String
  public var email: String
  public var password: String

  public init(
    firstName: String,
    lastName: String,
    email: String,
    password: String
  ) {
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.password = password
  }

  public var __variables: Variables? { [
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password
  ] }

  public struct Data: RokayaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("customerCreate", CustomerCreate?.self, arguments: ["input": [
        "firstName": .variable("firstName"),
        "lastName": .variable("lastName"),
        "email": .variable("email"),
        "password": .variable("password")
      ]]),
    ] }

    /// Creates a new customer.
    public var customerCreate: CustomerCreate? { __data["customerCreate"] }

    /// CustomerCreate
    ///
    /// Parent Type: `CustomerCreatePayload`
    public struct CustomerCreate: RokayaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.CustomerCreatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("customer", Customer?.self),
        .field("customerUserErrors", [CustomerUserError].self),
      ] }

      /// The created customer object.
      public var customer: Customer? { __data["customer"] }
      /// The list of errors that occurred from executing the mutation.
      public var customerUserErrors: [CustomerUserError] { __data["customerUserErrors"] }

      /// CustomerCreate.Customer
      ///
      /// Parent Type: `Customer`
      public struct Customer: RokayaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { RokayaAPI.Objects.Customer }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("email", String?.self),
          .field("firstName", String?.self),
          .field("id", RokayaAPI.ID.self),
          .field("lastName", String?.self),
        ] }

        /// The customer’s email address.
        public var email: String? { __data["email"] }
        /// The customer’s first name.
        public var firstName: String? { __data["firstName"] }
        /// A unique ID for the customer.
        public var id: RokayaAPI.ID { __data["id"] }
        /// The customer’s last name.
        public var lastName: String? { __data["lastName"] }
      }

      /// CustomerCreate.CustomerUserError
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
