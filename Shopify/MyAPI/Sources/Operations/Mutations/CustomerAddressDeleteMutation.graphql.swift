// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CustomerAddressDeleteMutation: GraphQLMutation {
  public static let operationName: String = "CustomerAddressDelete"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CustomerAddressDelete($token: String!, $addressId: ID!) { customerAddressDelete(id: $addressId, customerAccessToken: $token) { __typename deletedCustomerAddressId } }"#
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

  public struct Data: MyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { MyAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("customerAddressDelete", CustomerAddressDelete?.self, arguments: [
        "id": .variable("addressId"),
        "customerAccessToken": .variable("token")
      ]),
    ] }

    /// Permanently deletes the address of an existing customer.
    public var customerAddressDelete: CustomerAddressDelete? { __data["customerAddressDelete"] }

    /// CustomerAddressDelete
    ///
    /// Parent Type: `CustomerAddressDeletePayload`
    public struct CustomerAddressDelete: MyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { MyAPI.Objects.CustomerAddressDeletePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("deletedCustomerAddressId", String?.self),
      ] }

      /// ID of the deleted customer address.
      public var deletedCustomerAddressId: String? { __data["deletedCustomerAddressId"] }
    }
  }
}
