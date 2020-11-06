//
//  ImageScrollerTests.swift
//  ImageScrollerTests
//
//  Created by Rahul on 06/11/20.
//

import XCTest
@testable import ImageScroller

class ImageScrollerTests: XCTestCase {

  
    func testAPIRESPONCE()
   {
       
        //---------- Getting Image List ----- //
        
       APIPARSHER.instance().makeAPICall(url: "list", params:nil, method: .GET, success:
           { (data, response, error) in
               // API call is Successfull
               NSLog("Successfull")
       
               do
               {
                    let model  = try JSONDecoder().decode(Array<Detail>.self, from: data!)
                   
                let RESP = model.first!
            
                //----- Api Responce Model should be same as the recieving Model -------- //
                XCTAssertTrue( ((RESP as? Detail) != nil))
                
               
               }
               catch
               {
                   debugPrint(error)
               }
       }, failure:
           { (data, response, error) in
               // API call Failure
               NSLog("Failure")
               print(response ?? "hello")
               let jsonString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
               print(jsonString)
              
       })

   }
    
  
 
 }
