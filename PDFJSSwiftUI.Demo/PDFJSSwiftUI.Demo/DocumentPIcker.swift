//
//  DocumentPIcker.swift
//  PDFJSSwiftUI.Demo
//
//  Created by Andrii on 19.06.2022.
//

import Foundation
import UIKit
import SwiftUI
import MobileCoreServices
import UniformTypeIdentifiers

struct DocumentPicker : UIViewControllerRepresentable {
    @Binding var filePath: String
    
    func makeCoordinator() -> DocumentPickerCoordinator {
        return DocumentPickerCoordinator(filePath: self.$filePath)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller: UIDocumentPickerViewController
        
        if #available(iOS 14, *) {
            controller = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf], asCopy: true)
        } else {
            controller = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        }
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        
    }
}

class DocumentPickerCoordinator : NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
    @Binding var filePath: String
    
    init(filePath: Binding<String>) {
        _filePath = filePath
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let fileUrl = urls[0]
        
        do {
            filePath = try fileUrl.path
        } catch let error{
            print(error.localizedDescription)
        }
    }
}
