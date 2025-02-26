//
//  ShopifyTests.swift
//  ShopifyTests
//
//  Created by Yasser Yasser on 09/02/2025.
//

import XCTest
@testable import Shopify

final class ShopifyTests: XCTestCase {
    
    var validToken = "cd293e836bd1a612b61854db963f3b8e"
    var inValidToken = ""
    var validAddressId = "gid://shopify/MailingAddress/8923168899127?model_name=CustomerAddress&customer_access_token=B4QLS2BPa3_Tw06f--tZvH_QEBk0aA3HuCQDy4bWEq0lyqqB2N46pxYJ_WTc6EGJKG72gFtKotgCcRAGgLfRIqr0bdh9TuqQ_lQpTbyOeMKDDUZhEMPbNI2JI1Gz_rc7cJfRa2OCyKB2zV53x_p2sS3V6qoWBqOfjBfO-sQebpdOhCMHXfMRPdvP4nCy9XxdwXl-yMF8Xkqqx6Q-wV9sInt5R_aBHejgyAWrQlFYW-V0IO2U0ryspM5wFezkZeSc"
    var invalidAddressId = ""
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchCustomerDetailsFromModel() {
        
        let token = validToken
        let expectation = self.expectation(description: "Fetch customer details success")
        
        ApolloCustomerNetworkService.fetchCustomerDetailsFromModel(token: token) { result in
            switch result {
            case .success(let graphQLResult):
                XCTAssertNotNil(graphQLResult.data)
            case .failure(let error):
                XCTFail("Expected success, but got failure: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testFetchCustomerAddresses() {
        let expectation = self.expectation(description: "Fetch customer addresses success")
        
        ApolloAddressesNetwokService.fetchCustomerAddresses(token: validToken) { result in
            // Assert
            switch result {
            case .success(let graphQLResult):
                XCTAssertNotNil(graphQLResult.data)
            case .failure(let error):
                XCTFail("Expected success, but got failure: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testFetchCustomerDefaultAddresses() {
        let expectation = self.expectation(description: "Fetch customer default addresses success")
        
        ApolloAddressesNetwokService.fetchCustomerDefaultAddresses(token: validToken) { result in
            switch result {
            case .success(let graphQLResult):
                XCTAssertNotNil(graphQLResult.data)
            case .failure(let error):
                XCTFail("Expected success, but got failure: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testDeleteCustomerAddresses() {
        let addressId = validAddressId
        let expectation = self.expectation(description: "Delete customer addresses success")
        
        ApolloAddressesNetwokService.deleteCustomerAddresses(token: validToken, addressid: addressId) { result in
            switch result {
            case .success(let graphQLResult):
                XCTAssertNotNil(graphQLResult.data)
            case .failure(let error):
                XCTFail("Expected success, but got failure: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testCreateCustomerAddresses() {
        let address = Addresses(
            country: "USA",
            city: "New York",
            address1: "123 Main St",
            address2: "Apt 4",
            phone: "123-456-7890",
            id: nil,
            countryCode: "US"
        )
        let expectation = self.expectation(description: "Create customer addresses success")
        
        ApolloAddressesNetwokService.createCustomerAddresses(token: validToken, address: address) { result in
            switch result {
            case .success(let graphQLResult):
                XCTAssertNotNil(graphQLResult.data)
            case .failure(let error):
                XCTFail("Expected success, but got failure: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchCollections() {
        let expectation = self.expectation(description: "Fetch collections success")
        
        ApolloProductsNetwokService.fetchCollections { result in
            switch result {
            case .success(let graphQLResult):
                XCTAssertNotNil(graphQLResult.data)
            case .failure(let error):
                XCTFail("Expected success, but got failure: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    //        func testFetchProducts() {
    //            // Arrange
    //            let expectation = self.expectation(description: "Fetch products success")
    //
    //            ApolloProductsNetwokService.fetchProducts(query: ) { result in
    //                // Assert
    //                switch result {
    //                case .success(let graphQLResult):
    //                    XCTAssertNotNil(graphQLResult.data)
    //                case .failure(let error):
    //                    XCTFail("Expected success, but got failure: \(error.localizedDescription)")
    //                }
    //                expectation.fulfill()
    //            }
    //
    //            waitForExpectations(timeout: 10, handler: nil)
    //        }
    //
    //        func testFetchProducts_Failure() {
    //            // Arrange
    //            let expectation = self.expectation(description: "Fetch products failure")
    //
    //            // Act
    //            ApolloProductsNetwokService.fetchProducts(query: ) { result in
    //                // Assert
    //                switch result {
    //                case .success:
    //                    XCTFail("Expected failure, but got success")
    //                case .failure(let error):
    //                    XCTAssertNotNil(error)
    //                }
    //                expectation.fulfill()
    //            }
    //
    //            waitForExpectations(timeout: 10, handler: nil)
    //        }
    
    func testFetchCustomerOrder() {
        // Arrange
        let expectation = self.expectation(description: "Fetch customer orders success")
        
        // Act
        ApolloProductsNetwokService.fetchCustomerOrders(token: validToken) { result in
            // Assert
            switch result {
            case .success(let graphQLResult):
                XCTAssertNotNil(graphQLResult.data)
            case .failure(let error):
                XCTFail("Expected success, but got failure: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testFetchCustomerDetailsFromModel_Failure() {
        let token = inValidToken // Use an invalid token
        let expectation = self.expectation(description: "Fetch customer details failure")
        
        ApolloCustomerNetworkService.fetchCustomerDetailsFromModel(token: token) { result in
            switch result {
            case .success(let graphQLResult):
                if let customer = graphQLResult.data?.customer {
                    XCTFail("Expected failure, but got success with customer data: \(customer)")
                } else if let errors = graphQLResult.errors, !errors.isEmpty {
                    XCTAssertTrue(true)
                } else {
                    XCTAssertTrue(true)
                }
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
