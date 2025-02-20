// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == MyApi.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == MyApi.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == MyApi.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == MyApi.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "AppliedGiftCard": return MyApi.Objects.AppliedGiftCard
    case "Article": return MyApi.Objects.Article
    case "Blog": return MyApi.Objects.Blog
    case "Cart": return MyApi.Objects.Cart
    case "CartLine": return MyApi.Objects.CartLine
    case "CartUserError": return MyApi.Objects.CartUserError
    case "Collection": return MyApi.Objects.Collection
    case "CollectionConnection": return MyApi.Objects.CollectionConnection
    case "CollectionEdge": return MyApi.Objects.CollectionEdge
    case "Comment": return MyApi.Objects.Comment
    case "Company": return MyApi.Objects.Company
    case "CompanyContact": return MyApi.Objects.CompanyContact
    case "CompanyLocation": return MyApi.Objects.CompanyLocation
    case "ComponentizableCartLine": return MyApi.Objects.ComponentizableCartLine
    case "Customer": return MyApi.Objects.Customer
    case "CustomerAccessToken": return MyApi.Objects.CustomerAccessToken
    case "CustomerAccessTokenCreatePayload": return MyApi.Objects.CustomerAccessTokenCreatePayload
    case "CustomerAddressCreatePayload": return MyApi.Objects.CustomerAddressCreatePayload
    case "CustomerAddressDeletePayload": return MyApi.Objects.CustomerAddressDeletePayload
    case "CustomerCreatePayload": return MyApi.Objects.CustomerCreatePayload
    case "CustomerDefaultAddressUpdatePayload": return MyApi.Objects.CustomerDefaultAddressUpdatePayload
    case "CustomerUserError": return MyApi.Objects.CustomerUserError
    case "ExternalVideo": return MyApi.Objects.ExternalVideo
    case "GenericFile": return MyApi.Objects.GenericFile
    case "Image": return MyApi.Objects.Image
    case "ImageConnection": return MyApi.Objects.ImageConnection
    case "ImageEdge": return MyApi.Objects.ImageEdge
    case "Location": return MyApi.Objects.Location
    case "MailingAddress": return MyApi.Objects.MailingAddress
    case "MailingAddressConnection": return MyApi.Objects.MailingAddressConnection
    case "MailingAddressEdge": return MyApi.Objects.MailingAddressEdge
    case "Market": return MyApi.Objects.Market
    case "MediaImage": return MyApi.Objects.MediaImage
    case "MediaPresentation": return MyApi.Objects.MediaPresentation
    case "Menu": return MyApi.Objects.Menu
    case "MenuItem": return MyApi.Objects.MenuItem
    case "Metafield": return MyApi.Objects.Metafield
    case "MetafieldDeleteUserError": return MyApi.Objects.MetafieldDeleteUserError
    case "MetafieldsSetUserError": return MyApi.Objects.MetafieldsSetUserError
    case "Metaobject": return MyApi.Objects.Metaobject
    case "Model3d": return MyApi.Objects.Model3d
    case "MoneyV2": return MyApi.Objects.MoneyV2
    case "Mutation": return MyApi.Objects.Mutation
    case "Order": return MyApi.Objects.Order
    case "OrderConnection": return MyApi.Objects.OrderConnection
    case "OrderEdge": return MyApi.Objects.OrderEdge
    case "Page": return MyApi.Objects.Page
    case "Product": return MyApi.Objects.Product
    case "ProductConnection": return MyApi.Objects.ProductConnection
    case "ProductEdge": return MyApi.Objects.ProductEdge
    case "ProductOption": return MyApi.Objects.ProductOption
    case "ProductOptionValue": return MyApi.Objects.ProductOptionValue
    case "ProductPriceRange": return MyApi.Objects.ProductPriceRange
    case "ProductVariant": return MyApi.Objects.ProductVariant
    case "QueryRoot": return MyApi.Objects.QueryRoot
    case "SearchQuerySuggestion": return MyApi.Objects.SearchQuerySuggestion
    case "SellingPlan": return MyApi.Objects.SellingPlan
    case "Shop": return MyApi.Objects.Shop
    case "ShopPayInstallmentsFinancingPlan": return MyApi.Objects.ShopPayInstallmentsFinancingPlan
    case "ShopPayInstallmentsFinancingPlanTerm": return MyApi.Objects.ShopPayInstallmentsFinancingPlanTerm
    case "ShopPayInstallmentsProductVariantPricing": return MyApi.Objects.ShopPayInstallmentsProductVariantPricing
    case "ShopPolicy": return MyApi.Objects.ShopPolicy
    case "TaxonomyCategory": return MyApi.Objects.TaxonomyCategory
    case "UrlRedirect": return MyApi.Objects.UrlRedirect
    case "UserError": return MyApi.Objects.UserError
    case "UserErrorsShopPayPaymentRequestSessionUserErrors": return MyApi.Objects.UserErrorsShopPayPaymentRequestSessionUserErrors
    case "Video": return MyApi.Objects.Video
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
