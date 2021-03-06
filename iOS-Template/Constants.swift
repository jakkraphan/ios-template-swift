//
//  Constants.swift
//  iOS-Template
//

import UIKit

/*----------API keys---------*/
let SBKeyAPIKeyCrashlitycs  = ""
let SBKeyAPIKeyHockeyApp    = ""
let SBKeyAPIKeyGoogle       = ""

/*--------------User Defaults keys-------------*/
let SBKeyUserDefaultsDeviceTokenData = "kUserDefaultsDeviceTokenData"
let SBKeyUserDefaultsDeviceTokenString = "kUserDefaultsDeviceTokenString"

/*----------Notifications---------*/
let SBNotificationMock:String = "mock_notification";

/*--------------Fonts-------------*/

//Example of custom font family name
enum FontFamilyName {
    case Regular
    case Bold
    case Italic
    
    static let fontFamilyName = "FontFamilyName"
    static let allValues = [FontFamilyName.Regular, FontFamilyName.Bold, FontFamilyName.Italic]
    
    var description : String {
        switch self {
        case .Regular:  return "FontFamilyName-Regular";
        case .Bold:     return "FontFamilyName-Bold";
        case .Italic:   return "FontFamilyName-Italic";
        }
    }
    
    func font (size:CGFloat) -> UIFont? {
        switch self {
        case .Regular:  return UIFont(name: self.description, size: size)
        case .Bold:     return UIFont(name: self.description, size: size)
        case .Italic:   return UIFont(name: self.description, size: size)
        }
    }
}

/*----------Colors----------*/

//Example of custom color schemes in application
let MyRedApplicationColor = UIColor.redColor()
let MyGreenApplicationColor = UIColor.greenColor()
