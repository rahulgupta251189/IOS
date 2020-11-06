//
//  ContentView.swift
//  ImageScroller
//
//  Created by Rahul on 20/10/20.
//

import SwiftUI
import  KingfisherSwiftUI



struct ContentView: View
{
    
    @State var isLoading = false
    @State var ImageList = [Detail]()
    @State var AuthorList = [String]()
    
    
    

   // @State var orientation = UIDevice.current.orientation

    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
        
    fileprivate func NoDataScreen() -> some View {
        return VStack(spacing: 20)
        {
            Image("no_List")
            
            Text("No Data Found")
                .lineLimit(2)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .font(.custom("OpenSans-Bold", size: 20))
            
            Text("Please Check your device network ")
                .lineLimit(2)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .font(.custom("OpenSans-Light", size: 16))
            
            
            Button(action:
                    {
                        self.PullDATA()
                    }, label: {
                        Text("Reload Data")
                            .lineLimit(2)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .font(.custom("OpenSans-SemiBold", size: 16))
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                    })
            
            
            
            
            
            
        }.padding(.horizontal , 20).padding(.bottom , 100)
    }
    
    var body: some View {
            
            
            LoadingView(isShowing: $isLoading)
            {
                NavigationView
                {
                
                ZStack
                {
                    
                    VStack
                    {
                   
                    if horizontalSizeClass == .compact && verticalSizeClass == .regular
                    {

                        withAnimation
                        {
                           
                            PORTRAIT(AuthorList: self.AuthorList , ImageList : self.ImageList , SelectedAuthor :(self.AuthorList.first ?? "") )
                        }

                    }
                    else if horizontalSizeClass == .regular && verticalSizeClass == .compact
                    {

                        withAnimation
                        {
                           
                            LANDSCAPE(AuthorList: self.AuthorList , ImageList : self.ImageList , SelectedAuthor :(self.AuthorList.first ?? "") )
                        }


                }
                     
                        
                        Spacer()
                        
                    }
              
                }
                   
                .navigationBarHidden(false)
                .navigationBarTitle("Assignment")
                .navigationBarItems(trailing:
                                        NavigationLink( destination: SearchScreen())
                                        {
                                            Image(systemName: "magnifyingglass")
                                            .foregroundColor(.black)
                                            .padding(.leading, 8)
                                            
                                        })
                .onAppear(perform:{
                    self.PullDATA()
                    })
                    
                    
                }.navigationViewStyle(StackNavigationViewStyle())
                
            }
            
         
        }
    
    fileprivate  func PullDATA()
   {
       
       self.isLoading = true
        
        //---------- Getting Image List ----- //
        
       APIPARSHER.instance().makeAPICall(url: "list", params:nil, method: .GET, success:
           { (data, response, error) in
               // API call is Successfull
               NSLog("Successfull")
            self.isLoading = false
               do
               {
                 
                    // Date will be print in the console on uncomment
                    //let jsonString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
                    //print(jsonString)
                
                    self.ImageList  = try JSONDecoder().decode(Array<Detail>.self, from: data!)
                    let AuthList = Dictionary(grouping:  self.ImageList , by: { $0.author! })
                    self.AuthorList = Array(AuthList.keys)
                
                Global.sharedInstance.SelectedAuthor = self.AuthorList.first ?? ""
                Global.sharedInstance.FilterList = Global.sharedInstance.Filter(Name:  Global.sharedInstance.SelectedAuthor, List:  self.ImageList )
               
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
               self.isLoading = false
       })

   }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}


