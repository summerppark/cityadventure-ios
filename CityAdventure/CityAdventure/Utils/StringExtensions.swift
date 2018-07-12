//
//  StringExtensions.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 27..
//  Copyright © 2018년 bubu. All rights reserved.
//

import Foundation

extension String {
    
    // Email Regex
    var validEmailAddress: Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Z0-9a-z.-_]+\\.[A-Za-z]{2,3}"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let results = regex.matches(in: self, range: NSRange(location: 0, length: self.count))
            
            if results.count == 0 {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return returnValue
    }
    
    func isPasswordValid() -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-zA-Z]+)(?=.*[!@#$%^*+=-]|.*[0-9]+).{8,16}$")
        return passwordTest.evaluate(with: self) && !self.isEmpty
    }
    
    
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
             let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                                                                                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue]
            return try NSAttributedString(data: data, options: options, documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
    
    
    
}
