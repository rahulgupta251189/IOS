//
//  Modifier.swift
//  ImageScroller
//
//  Created by Rahul on 20/10/20.
//

import SwiftUI

struct  RGHeading : ViewModifier
{
    func body(content: Content) -> some View
    {
        return content
            .foregroundColor(Color.black)//textlablecolor
            .font(.custom("OpenSans-SemiBold", size: 19))
    }
}


struct  RGSubheading : ViewModifier
{
    func body(content: Content) -> some View
    {
        return content//.foregroundColor(Color.black)//textlablecolor
            .font(.custom("OpenSans-Regular", size: 13)).multilineTextAlignment(.leading)
        
            
         
    }
}
