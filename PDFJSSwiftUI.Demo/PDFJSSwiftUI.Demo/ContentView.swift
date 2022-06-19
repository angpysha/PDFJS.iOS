//
//  ContentView.swift
//  PDFJSSwiftUI.Demo
//
//  Created by Andrii on 19.06.2022.
//

import SwiftUI
import PDFJS

struct ContentView: View {
    
    @State private var fileUrl = ""
    @State private var isControllerPresented = false
    
    var body: some View {
        VStack {
            Button("Pick file") {
                isControllerPresented = true
            }.padding()
            
            PDFJS(source: self.$fileUrl.toUrl())
            
            Spacer()
        }.sheet(isPresented: self.$isControllerPresented) {
            DocumentPicker(filePath: self.$fileUrl)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Binding where Value == String {
    func toUrl() -> Binding<URL?> {
        return Binding<URL?>(get: {URL.init(fileURLWithPath: self.wrappedValue)},
                            set: {self.wrappedValue = $0?.absoluteString ?? ""})
    }
}
