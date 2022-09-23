//
//  FileManager.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/19.
//

import UIKit

class ContentLoader {
    var prop = Properties()
    var generatedArray = [String]()
    static var generatedList = CardList(id: 0, card: ["one","two"])
    
    func loadSet(setNumber: Int) {
        
        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent("Images.bundle")
        
        do {
            let contents = try fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)
            
            for item in contents {
                let fileString = item.lastPathComponent
                if fileString.hasPrefix("set\(setNumber)_") {
                    
                    if generatedArray.count < 24 {
                        generatedArray.append(fileString)
                        generatedArray.append(fileString)
                        generatedArray.sort()
                    }
                    //FIRST CUTTED METHOD:
                    ContentLoader.generatedList = CardList(id: setNumber, card: generatedArray)
                }
            }
            generatedArray.removeAll()
            
            //SECOND CUTTED METHOD:
            Properties.cardCollection.append(ContentLoader.generatedList.card)
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
