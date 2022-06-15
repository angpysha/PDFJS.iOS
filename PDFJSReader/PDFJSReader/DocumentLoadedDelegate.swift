//
//  DocumentLoadedDelegate.swift
//  PDFJSReader
//
//  Created by Andrii on 13.06.2022.
//

import Foundation

@objc protocol DocumentLoadedDelegate {
    func loaded(withObject obj: Any?, andError error: Error?)
}
