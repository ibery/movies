//
//  Stroryboard.swift
//  MobiMovie
//
//  Created by Narkoz on 27.07.2022.
//

import Foundation
import UIKit

enum Storyboard : Int {
    case main
    case detail
    
    var name : String {
        switch self {
        case .main:
            return "Main"
        case .detail:
            return "Detail"
        }
    }
    
    var storyboard : UIStoryboard{
        return UIStoryboard(name: "\(self.name)Screen", bundle: nil)
    }
    
    var viewController : UIViewController? {
        return self.storyboard.instantiateInitialViewController()
    }
}
