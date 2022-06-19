//
//  File.swift
//  
//
//  Created by Andrii on 19.06.2022.
//

import Foundation
import UIKit
import SwiftUI

@available(iOS 13.0, *)
public struct PDFJS : UIViewRepresentable {
    
    @Binding var source: URL?
    
    public init(source: Binding<URL?>?) {
        self._source = source ?? Binding.constant(nil)
    }
    
    public init() {
        self._source = Binding.constant(nil)
    }
    
    public func makeUIView(context: Context) -> PDFJSView {
        return PDFJSView()
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        if source != nil {
            uiView.source = source
        }
    }
}

@available(iOS 13.0, *)
public extension PDFJS {
    public mutating func url(_ source: Binding<URL?>) {
        self._source = source
    }
}
