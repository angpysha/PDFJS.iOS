//
//  ViewController.swift
//  PDFJS.Demo
//
//  Created by Andrii on 15.06.2022.
//

import UIKit
import PDFJS
import MobileCoreServices
import UniformTypeIdentifiers

class ViewController: UIViewController, UIDocumentPickerDelegate {
    @IBOutlet weak var ouletPdfView: PDFJSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func tapped(_ sender: Any) {
        
        let types = UTType.types(tag: "pdf",
                                     tagClass: UTTagClass.filenameExtension,
                                     conformingTo: nil)
//            let documentPickerController = UIDocumentPickerViewController(
//                    forOpeningContentTypes: types
//)
        
        let documentPickerController = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
            documentPickerController.delegate = self
            self.present(documentPickerController, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        let first = urls.first
        
        
        ouletPdfView.source = first
        
    }
    
}

