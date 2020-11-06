//
//  CustomCells.swift
//  ImageScroller
//
//  Created by Rahul on 06/11/20.
//

import SwiftUI
import  KingfisherSwiftUI

struct LANDSCAPE: View
{
    var AuthorList = [String]()
    var ImageList = [Detail]()
    
    @State var FilterList = [Detail]()
    @State var SelectedAuthor =  ""

        let columns = [
            GridItem(.adaptive(minimum: UIScreen.main.bounds.width))
        ]

  
    @State var isHideList : Bool = false
    
    func printRG(STR : String)
    {
        print("\(STR)")
    }
    
    var body: some View
    {
            ZStack
            {
                
                GeometryReader { geometry in
                
                    
                    
                ScrollView(showsIndicators: false)
                {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach((self.FilterList.count > 0 ? self.FilterList : Global.sharedInstance.FilterList), id: \.self)
                              { item in
                            
                                let str_width = Int(geometry.size.width)
                                let str_height = Int(geometry.size.height)


                                let URLRG = URL.init(string: "https://picsum.photos/id/\(item.id ?? 0)/\(str_width)/\(str_height)")
                                KFImage(URLRG)
                                .resizable()
                                .aspectRatio(geometry.size, contentMode: .fill)
                                .edgesIgnoringSafeArea(.all)
                                
                                
                              }
                          }
                          
                }.onTapGesture(count: 1, perform: {
                    
                    withAnimation {
                        self.isHideList.toggle()
                    }
                })
                    
                }
                
                if(!isHideList)
                {
                ZStack
                {
                    VStack
                    {
                    
                    Spacer()
                        ScrollView(.horizontal,showsIndicators: false)
                        {
                           HStack(spacing: 10)
                           {
                              ForEach(AuthorList , id: \.self )
                              { ITEAM  in
                                Author_cell( TextColor : Color.white, TTL: ITEAM)
                                    .onTapGesture(perform:{
                                        print("BUTTON PRESSED")
                                        self.SelectedAuthor = ITEAM
                                        self.FilterList =  Global.sharedInstance.Filter(Name: self.SelectedAuthor , List: self.ImageList)
                                  })
                                    
                              }
                            
                           }
                          
                            
                            
                        }
                 
                        
                    }
                    
                }
                }
                
            }
           
            
            .navigationBarHidden(true)
      
    
            
    }
  
    
}

struct PORTRAIT: View
{
    var AuthorList = [String]()
    var ImageList = [Detail]()
    
    
    @State var FilterList = [Detail]()
    @State var SelectedAuthor =  ""
    


        let columns = [
            GridItem(.adaptive(minimum: UIScreen.main.bounds.width ))
        ]

 
    var body: some View
    {
        
      
       
        VStack (alignment: .leading, spacing: 10)
        {
            Spacer().frame(height: 10)
            
            Text("Author List").modifier(RGHeading())
            
            ScrollView(.horizontal,showsIndicators: false)
            {
               HStack(spacing: 10)
               {
                  ForEach(AuthorList , id: \.self )
                  { ITEAM  in
                      Author_cell( TTL: ITEAM)
                        .onTapGesture(perform:{
                            print("BUTTON PRESSED")
                            self.SelectedAuthor = ITEAM
                            self.FilterList =  Global.sharedInstance.Filter(Name: self.SelectedAuthor , List: self.ImageList)
                      })
                        
                  }
                
               }
              
                
                
            }
            
            
            Spacer().frame(height: 10)
            
            if(self.FilterList.count > 0)
            {
             Text("We Found \(self.FilterList.count) Images by \(self.SelectedAuthor)").modifier(RGHeading())
            }
            else
            {
               
                Text("We Found \( Global.sharedInstance.FilterList.count) Images by \( Global.sharedInstance.SelectedAuthor)").modifier(RGHeading())
            }
            
            ScrollView(showsIndicators: false)
            {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach((self.FilterList.count > 0 ? self.FilterList : Global.sharedInstance.FilterList), id: \.self)
                          { item in

                           Image_cell(Iteam : item)

                          }
                      }
                      
            }
            
            
            Spacer()
            
        }.padding(.horizontal , 20)
            
        .navigationBarHidden(true)

    
            
    }
  
    

    
    
}

struct Author_cell: View
{
    var TextColor = Color.black
    var TTL = ""
    var body121212: some View
    {
        VStack
        {
          Button(action: {
            print("Button tapped")
        }) {

            let URLRG = URL.init(string: "https://picsum.photos/seed/picsum/80/80")
            KFImage(URLRG)
            .clipShape(Circle())
            
        }
            
            Text("\(TTL)")
                .modifier(RGSubheading())
                .foregroundColor(TextColor)
        
        }
    }
    
    var body: some View
    {
        VStack
        {
        
            let URLRG = URL.init(string: "https://picsum.photos/seed/picsum/80/80")
            KFImage(URLRG)
            .clipShape(Circle())
            
            
            Text("\(TTL)")
                .modifier(RGSubheading())
                .foregroundColor(TextColor)
        
        }
    }
}

struct Image_cell: View
{
    var Iteam = Detail()
    
    var body: some View
    {
       
        let URLRG = URL.init(string: "https://picsum.photos/id/\(Iteam.id ?? 0)/374/300")
        
            KFImage(URLRG)
            .placeholder({Image("PlaceHolder")})
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.top)
      
       
    }
}

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack
                {
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                    Text("Please wait...").font(.custom("OpenSans-SemiBold", size: 22))
                        .foregroundColor(.white)
                   
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
               // .background(Color.secondary.colorInvert())
                .background(Color.gray)
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}



