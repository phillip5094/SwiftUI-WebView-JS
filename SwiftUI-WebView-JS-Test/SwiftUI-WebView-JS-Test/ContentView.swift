//
//  ContentView.swift
//  SwiftUI-WebView-JS-Test
//
//  Created by Philip Chung on 2023/02/27
//  
//
        

import SwiftUI

struct ContentView: View {
    let webView = WebView(request: URLRequest(url: URL(string: "https://phillip5094.github.io/MyTestPage/iOSWebViewCommunication.html")!))
    
    var body: some View {
        VStack {
            webView
                .padding(5)
                .background(.yellow)
                .frame(height: 400)
            
            Button("Call JavaScript Function") {
                webView.callJS()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
