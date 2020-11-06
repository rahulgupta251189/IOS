//
//  APIPARSHER.swift
//  CAM-POC
//
//  Created by Rahul on 05/04/19.
//  Copyright © 2019 Aditya. All rights reserved.
//

import UIKit



let baseURL : String = "https://picsum.photos/"


enum HttpMethod : String {
    case  GET
    case  POST
    case  DELETE
    case  PUT
}


class APIPARSHER: NSObject {
    
    
    var request : URLRequest?
    var session : URLSession?
    
    static func instance() ->  APIPARSHER{
        
        return APIPARSHER()
    }


    
  public  func makeAPICall(url: String,params: Dictionary<String, Any>?, method: HttpMethod, success:@escaping ( Data? ,HTTPURLResponse?  , NSError? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void)
  {
    
        let FinalURL = String(format: "%@%@", baseURL,url)
        request = URLRequest(url: URL(string: FinalURL)!)
        if let params = params
        {
             
            let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request?.setValue("application/json", forHTTPHeaderField:"Content-Type")
            request?.addValue("application/json", forHTTPHeaderField: "Accept")
            request?.httpBody =  jsonData
        }
    
   
        request?.httpMethod = method.rawValue
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        
        session = URLSession(configuration: configuration)
        let AuthTokenString = UserDefaults.standard.value(forKey: "Authorization") as? String  ?? ""
 
       request!.addValue("Bearer " + AuthTokenString, forHTTPHeaderField: "Authorization")
    
        
        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
            
            if let data = data
            {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode
                {
                    success(data , response , error as NSError?)
                }
                else
                {
                    failure(data , response as? HTTPURLResponse, error as NSError?)
                }
            }
            else
            {
                failure(data , response as? HTTPURLResponse, error as NSError?)
            }
            }.resume()
        
    }

}



