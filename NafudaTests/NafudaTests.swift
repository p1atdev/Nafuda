//
//  NafudaTests.swift
//  NafudaTests
//
//  Created by 周廷叡 on 2021/01/16.
//

import XCTest
@testable import Nafuda

class NafudaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        let _ = Nafuda(link: "https://githfhaheouwafnaw.awboeufbwa").getTitle(completion: { response in
            switch response.status {
            case .success:
                print(response.title!)
                
            case .fail:
                print("No title at the site.")
                
            case .error:
                print("Other error was occaused.")
            }
        })
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
