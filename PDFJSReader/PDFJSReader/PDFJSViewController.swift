//
//  PDFJSViewController.swift
//  PDFJSReader
//
//  Created by Andrii on 13.06.2022.
//
#if !os(macOS)
import UIKit
import WebKit

@objc class PDFJSViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    
    private var webView: WKWebView? = nil
    
    @objc weak var weakDelegate: DocumentLoadedDelegate? = nil
    @objc var delegate: DocumentLoadedDelegate? = nil
    
    @objc @IBInspectable var source: URL? {
        didSet {
            loadFile()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = WKWebViewConfiguration()
        configuration.setValue(true, forKey: "_allowUniversalAccessFromFileURLs")
        
        let bundle = Bundle(for: type(of: self))
        let path = bundle.url(forResource: "viewer", withExtension: "html", subdirectory: "pdfjs/web")
        
        webView = WKWebView(frame: containerView.frame, configuration: configuration)
        webView!.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(webView!)

        NSLayoutConstraint.activate([
            webView!.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            webView!.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            webView!.topAnchor.constraint(equalTo: containerView.topAnchor),
            webView!.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        let dir = path!.deletingLastPathComponent()
        
        webView!.loadFileURL(path!, allowingReadAccessTo: dir)
        // Do any additional setup after loading the view.
    }

    private func loadFile() {
        let jsString = "pdfjsLib.getDocument('\(source?.path)').promise.then(doc => { PDFViewerApplication.load(doc); });"
        webView?.evaluateJavaScript(jsString, completionHandler: { o, e in
            self.weakDelegate?.loaded(withObject: o, andError: e)
            self.delegate?.loaded(withObject: o, andError: e)
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
#endif
