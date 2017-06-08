//
//  JSONFileReader.swift
//  CustomStyles
//
//  Created by Jayesh Kawli on 6/8/17.
//  Copyright © 2017 Jayesh Kawli. All rights reserved.
//

import Foundation

class JSONFileReader: NSObject {
    /// Venue is optional. Just in case we encounter invalid data or malformed JSON input file.
    static func readJSONFile(with name: String) -> AppStyle? {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else { return nil }
        do {
            let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
            do {
                let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                if let style = jsonResult as? NSDictionary {
                    return AppStyle(styleInformation: style)
                }
            } catch {
                print("Error occurred while trying to convert JSON data into Swift types")
            }
        } catch {
            print("Error occurred while trying to read contents of file \(name)")
        }
        /// Simply return a nil value when unplesant situation is encountered.
        return nil
    }
}
