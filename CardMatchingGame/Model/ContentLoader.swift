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
//                let imageString = fileString.deletingSuffix(".png")
//                if imageString.hasPrefix("set\(setNumber)_") {
                if fileString.hasPrefix("set\(setNumber)_") {
//                    let completedString = fileString.deletingPrefix("set\(setNumber)_")
                    switch setNumber {
                    case 1:
                        if Properties.cardList1.count < 10 {
                            Properties.cardList1.append(fileString)
                        }
                    case 2:
                        if Properties.cardList2.count < 10 {
                            Properties.cardList2.append(fileString)
                        }
                    case 3:
                        if Properties.cardList3.count < 10 {
                            Properties.cardList3.append(fileString)
                        }
                    default: break
                    }
                }
            }
            
            switch setNumber {
            case 1:
                Properties.cardList1.append(contentsOf: Properties.cardList1)
                Properties.cardList1.sort()
                Properties.cardCollection.append(Properties.cardList1)
            case 2:
                Properties.cardList2.append(contentsOf: Properties.cardList2)
                Properties.cardList2.sort()
                Properties.cardCollection.append(Properties.cardList2)
            case 3:
                Properties.cardList3.append(contentsOf: Properties.cardList3)
                Properties.cardList3.sort()
                Properties.cardCollection.append(Properties.cardList3)
            default: break
            }
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    func getImage(name: String) -> UIImage? {
        if let imgPath = Bundle.main.path(forResource: name, ofType: ".png") {
            return UIImage(contentsOfFile: imgPath)
        }
        return nil
    }
}
