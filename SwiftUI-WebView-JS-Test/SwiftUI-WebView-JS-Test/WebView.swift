//
//  WebView.swift
//  SwiftUI-WebView-JS-Test
//
//  Created by Philip Chung on 2023/02/27
//  
//
        

import SwiftUI
import WebKit

class ContentController: NSObject, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "serverEvent" {
            print("message name : \(message.name)")
            print("post Message : \(message.body)")
        }
    }
}

struct WebView: UIViewRepresentable {
    let request: URLRequest
    private var webView: WKWebView?
    
    init(request: URLRequest) {
        self.webView = WKWebView()
        self.request = request
        self.webView?.configuration.userContentController.add(ContentController(), name: "serverEvent")
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    

    class Coordinator: NSObject {
        let parent: WebView
        
        init(parent: WebView) {
            self.parent = parent
        }
    }
}

extension WebView {
    func callJS(_ args: Any = "") {
        webView?.evaluateJavaScript("iOSToJavaScript('\(args)')") { result, error in
            if let error {
                print("Error \(error.localizedDescription)")
                return
            }
            
            if result == nil {
                print("It's void function")
                return
            }
            
            print("Received Data \(result ?? "")")
        }
    }
}
