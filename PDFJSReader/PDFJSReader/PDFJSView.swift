//
//  PDFJSView.swift
//  PDFJSReader
//
//  Created by Andrii on 13.06.2022.
//
#if !os(macOS)
import UIKit
import WebKit

@objc public class PDFJSView: UIView {
    private var webView: WKWebView? = nil
    
    @objc weak var weakDelegate: DocumentLoadedDelegate? = nil
    @objc var delegate: DocumentLoadedDelegate? = nil
    
    @objc @IBInspectable public var source: URL? {
        didSet {
            loadFile()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    @objc public override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    private func loadView() {
        let configuration = WKWebViewConfiguration()
        configuration.setValue(true, forKey: "_allowUniversalAccessFromFileURLs")
        
        let bundle = Bundle(for: type(of: self))
        var path = bundle.url(forResource: "viewer", withExtension: "html", subdirectory: "pdfjs/web")
        
        if path == nil {
            let moduleBundle = Bundle.module
            path = moduleBundle.url(forResource: "viewer", withExtension: "html", subdirectory: "pdfjs/web")
        }
        
        webView = WKWebView(frame: self.frame, configuration: configuration)
        webView!.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(webView!)

        NSLayoutConstraint.activate([
            webView!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            webView!.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            webView!.topAnchor.constraint(equalTo: self.topAnchor),
            webView!.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        let dir = path!.deletingLastPathComponent()
        
        webView!.loadFileURL(path!, allowingReadAccessTo: dir)
    }
    
    private func loadFile() {
        if source == nil {
            return
        }
        
      let jsString = "pdfjsLib.getDocument('\(source!.path)').promise.then(doc => { PDFViewerApplication.load(doc); });"
        
        webView?.evaluateJavaScript(jsString, completionHandler: { o, e in
            self.weakDelegate?.loaded(withObject: o, andError: e)
            self.delegate?.loaded(withObject: o, andError: e)
        })
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
#endif
