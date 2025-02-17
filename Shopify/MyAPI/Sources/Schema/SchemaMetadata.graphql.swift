// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == MyAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == MyAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == MyAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == MyAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "AppliedGiftCard": return MyAPI.Objects.AppliedGiftCard
    case "Article": return MyAPI.Objects.Article
    case "Blog": return MyAPI.Objects.Blog
    case "Cart": return MyAPI.Objects.Cart
    case "CartLine": return MyAPI.Objects.CartLine
    case "CartUserError": return MyAPI.Objects.CartUserError
    case "Collection": return MyAPI.Objects.Collection
    case "Comment": return MyAPI.Objects.Comment
    case "Company": return MyAPI.Objects.Company
    case "CompanyContact": return MyAPI.Objects.CompanyContact
    case "CompanyLocation": return MyAPI.Objects.CompanyLocation
    case "ComponentizableCartLine": return MyAPI.Objects.ComponentizableCartLine
    case "Customer": return MyAPI.Objects.Customer
    case "CustomerAddressCreatePayload": return MyAPI.Objects.CustomerAddressCreatePayload
    case "CustomerAddressDeletePayload": return MyAPI.Objects.CustomerAddressDeletePayload
    case "CustomerDefaultAddressUpdatePayload": return MyAPI.Objects.CustomerDefaultAddressUpdatePayload
    case "CustomerUserError": return MyAPI.Objects.CustomerUserError
    case "ExternalVideo": return MyAPI.Objects.ExternalVideo
    case "GenericFile": return MyAPI.Objects.GenericFile
    case "Image": return MyAPI.Objects.Image
    case "ImageConnection": return MyAPI.Objects.ImageConnection
    case "ImageEdge": return MyAPI.Objects.ImageEdge
    case "Location": return MyAPI.Objects.Location
    case "MailingAddress": return MyAPI.Objects.MailingAddress
    case "MailingAddressConnection": return MyAPI.Objects.MailingAddressConnection
    case "MailingAddressEdge": return MyAPI.Objects.MailingAddressEdge
    case "Market": return MyAPI.Objects.Market
    case "MediaImage": return MyAPI.Objects.MediaImage
    case "MediaPresentation": return MyAPI.Objects.MediaPresentation
    case "Menu": return MyAPI.Objects.Menu
    case "MenuItem": return MyAPI.Objects.MenuItem
    case "Metafield": return MyAPI.Objects.Metafield
    case "MetafieldDeleteUserError": return MyAPI.Objects.MetafieldDeleteUserError
    case "MetafieldsSetUserError": return MyAPI.Objects.MetafieldsSetUserError
    case "Metaobject": return MyAPI.Objects.Metaobject
    case "Model3d": return MyAPI.Objects.Model3d
    case "Mutation": return MyAPI.Objects.Mutation
    case "Order": return MyAPI.Objects.Order
    case "Page": return MyAPI.Objects.Page
    case "Product": return MyAPI.Objects.Product
    case "ProductConnection": return MyAPI.Objects.ProductConnection
    case "ProductEdge": return MyAPI.Objects.ProductEdge
    case "ProductOption": return MyAPI.Objects.ProductOption
    case "ProductOptionValue": return MyAPI.Objects.ProductOptionValue
    case "ProductVariant": return MyAPI.Objects.ProductVariant
    case "QueryRoot": return MyAPI.Objects.QueryRoot
    case "SearchQuerySuggestion": return MyAPI.Objects.SearchQuerySuggestion
    case "SellingPlan": return MyAPI.Objects.SellingPlan
    case "Shop": return MyAPI.Objects.Shop
    case "ShopPayInstallmentsFinancingPlan": return MyAPI.Objects.ShopPayInstallmentsFinancingPlan
    case "ShopPayInstallmentsFinancingPlanTerm": return MyAPI.Objects.ShopPayInstallmentsFinancingPlanTerm
    case "ShopPayInstallmentsProductVariantPricing": return MyAPI.Objects.ShopPayInstallmentsProductVariantPricing
    case "ShopPolicy": return MyAPI.Objects.ShopPolicy
    case "TaxonomyCategory": return MyAPI.Objects.TaxonomyCategory
    case "UrlRedirect": return MyAPI.Objects.UrlRedirect
    case "UserError": return MyAPI.Objects.UserError
    case "UserErrorsShopPayPaymentRequestSessionUserErrors": return MyAPI.Objects.UserErrorsShopPayPaymentRequestSessionUserErrors
    case "Video": return MyAPI.Objects.Video
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
