//
//  FileManager.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/19.
//

import UIKit

class ContentLoader {
    
    var prop = Properties()
    
    func loadSet(setNumber: Int) {
        
        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent("Images.bundle")
        
        do {
            let contents = try fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)
            
            for item in contents {
                let fileString = item.lastPathComponent
                let imageString = fileString.deletingSuffix(".png")
                if imageString.hasPrefix("set\(setNumber)_") {
                    let completedString = imageString.deletingPrefix("set\(setNumber)_")
                    switch setNumber {
                    case 1:
                        if prop.cardList1.count < 10 {
                            prop.cardList1.append(completedString)
                        }
                    case 2:
                        if prop.cardList2.count < 10 {
                            prop.cardList2.append(completedString)
                        }
                    case 3:
                        if prop.cardList3.count < 10 {
                            prop.cardList3.append(completedString)
                        }
                    default: break
                    }
                }
            }
            
            switch setNumber {
            case 1:
                prop.cardList1.append(contentsOf: prop.cardList1)
                prop.cardCollection.append(prop.cardList1)
            case 2:
                prop.cardList2.append(contentsOf: prop.cardList2)
                prop.cardCollection.append(prop.cardList2)
            case 3:
                prop.cardList3.append(contentsOf: prop.cardList3)
                prop.cardCollection.append(prop.cardList3)
            default: break
            }
        }
        catch let error as NSError {
            print(error)
        }
        print("set1 is \(prop.cardList1.count)")
        print("set2 is \(prop.cardList2.count)")
        print("set3 is \(prop.cardList3.count)")
        print(prop.cardCollection.count)
    }  
}
