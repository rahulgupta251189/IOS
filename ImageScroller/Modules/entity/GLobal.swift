//
//  GLobal.swift
//  CPPartner
//
//  Created by Rahul on 21/09/20.
//  Copyright © 2020 Aditya. All rights reserved.
//

import Foundation

struct  Detail : Decodable,Hashable
{
    var format : String?        // ": "jpeg",
    var width : Int?            //": 5616,
    var height : Int?           //": 3744,
    var filename : String?      //": "0.jpeg",
    var id : Int?               //": 0,
    var author : String?        //"Alejandro Escamilla",
    var author_url : String?    //"https://unsplash.com/photos/yC-Yzbqy7PY",
    var post_url : String?      //"https://unsplash.com/photos/yC-Yzbqy7PY"
}




class Global: NSObject
{
    @objc static let sharedInstance = Global()
    private override init() {}
    
    var FilterList = [Detail]()
     var SelectedAuthor =  ""
  

    func Filter(Name : String , List : [Detail]) -> [Detail]
    {
        var FinalList = [Detail]()
        
        for iteam in List
        {
            if(iteam.author == Name)
            {
                FinalList.append(iteam)
            }
        }

        Global.sharedInstance.SelectedAuthor = Name
        Global.sharedInstance.FilterList = FinalList
        
        return FinalList
        
    }

}
