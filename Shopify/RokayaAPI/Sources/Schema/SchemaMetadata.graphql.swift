// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == RokayaAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == RokayaAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == RokayaAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == RokayaAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "AppliedGiftCard": return RokayaAPI.Objects.AppliedGiftCard
    case "Article": return RokayaAPI.Objects.Article
    case "Blog": return RokayaAPI.Objects.Blog
    case "Cart": return RokayaAPI.Objects.Cart
    case "CartLine": return RokayaAPI.Objects.CartLine
    case "Collection": return RokayaAPI.Objects.Collection
    case "Comment": return RokayaAPI.Objects.Comment
    case "Company": return RokayaAPI.Objects.Company
    case "CompanyContact": return RokayaAPI.Objects.CompanyContact
    case "CompanyLocation": return RokayaAPI.Objects.CompanyLocation
    case "ComponentizableCartLine": return RokayaAPI.Objects.ComponentizableCartLine
    case "Customer": return RokayaAPI.Objects.Customer
    case "ExternalVideo": return RokayaAPI.Objects.ExternalVideo
    case "GenericFile": return RokayaAPI.Objects.GenericFile
    case "Image": return RokayaAPI.Objects.Image
    case "ImageConnection": return RokayaAPI.Objects.ImageConnection
    case "ImageEdge": return RokayaAPI.Objects.ImageEdge
    case "Location": return RokayaAPI.Objects.Location
    case "MailingAddress": return RokayaAPI.Objects.MailingAddress
    case "Market": return RokayaAPI.Objects.Market
    case "MediaImage": return RokayaAPI.Objects.MediaImage
    case "MediaPresentation": return RokayaAPI.Objects.MediaPresentation
    case "Menu": return RokayaAPI.Objects.Menu
    case "MenuItem": return RokayaAPI.Objects.MenuItem
    case "Metafield": return RokayaAPI.Objects.Metafield
    case "Metaobject": return RokayaAPI.Objects.Metaobject
    case "Model3d": return RokayaAPI.Objects.Model3d
    case "MoneyV2": return RokayaAPI.Objects.MoneyV2
    case "Order": return RokayaAPI.Objects.Order
    case "Page": return RokayaAPI.Objects.Page
    case "Product": return RokayaAPI.Objects.Product
    case "ProductConnection": return RokayaAPI.Objects.ProductConnection
    case "ProductEdge": return RokayaAPI.Objects.ProductEdge
    case "ProductOption": return RokayaAPI.Objects.ProductOption
    case "ProductOptionValue": return RokayaAPI.Objects.ProductOptionValue
    case "ProductVariant": return RokayaAPI.Objects.ProductVariant
    case "QueryRoot": return RokayaAPI.Objects.QueryRoot
    case "SearchQuerySuggestion": return RokayaAPI.Objects.SearchQuerySuggestion
    case "SellingPlan": return RokayaAPI.Objects.SellingPlan
    case "Shop": return RokayaAPI.Objects.Shop
    case "ShopPayInstallmentsFinancingPlan": return RokayaAPI.Objects.ShopPayInstallmentsFinancingPlan
    case "ShopPayInstallmentsFinancingPlanTerm": return RokayaAPI.Objects.ShopPayInstallmentsFinancingPlanTerm
    case "ShopPayInstallmentsProductVariantPricing": return RokayaAPI.Objects.ShopPayInstallmentsProductVariantPricing
    case "ShopPolicy": return RokayaAPI.Objects.ShopPolicy
    case "TaxonomyCategory": return RokayaAPI.Objects.TaxonomyCategory
    case "UrlRedirect": return RokayaAPI.Objects.UrlRedirect
    case "Video": return RokayaAPI.Objects.Video
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
