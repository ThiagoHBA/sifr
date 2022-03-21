import Foundation
import Erik
import SwiftSoup
import Cocoa

class CifraClubChords {
    private(set) var originUrl : String
    var musicName: String
    var tabs: Bool
    var twoColumns: Bool
    var bodyDiagrams: Bool
    var footerChords: Bool
    
    init(musicName: String, tabs: Bool, twoColumns: Bool, bodyDiagrams: Bool, footerChords: Bool) {
        self.musicName = musicName
        self.tabs = tabs
        self.twoColumns = twoColumns
        self.bodyDiagrams = bodyDiagrams
        self.footerChords = footerChords
        self.originUrl = "https://www.cifraclub.com.br"
    }
    
    func searchMusic() {
        obtainHtmlData(url: obtainMusicSearchUrl(musicName: self.musicName), completion: {
            (success, htmlData) in
            if success {

                let firstResultUrl = try! self.getFirstResultCifraClub(
                    document: SwiftSoup.parse(htmlData!)
                )!
            
                NSWorkspace.shared.open(URL(string: self.addURLParameters(urlString: firstResultUrl))!)

                exit(0)
            }
        })
    }


    func obtainHtmlData(url: String, completion: @escaping (Bool, String?) -> Void) {
        Erik.visit(url: URL(string: url)!) { object, error in
            if let e = error {
                completion(false, String(describing: e))
            } else if let doc = object {
                completion(true, String(describing: doc))
            }
        }
    }

    func getFirstResultCifraClub(document: SwiftSoup.Document) throws -> String? {
        var resultIndex: Int = 0
        
        let results = try document.getElementsByClass("gsc-webResult gsc-result")
        
        while results.count > resultIndex {
            let resultLink = try results[resultIndex].getElementsByClass("gs-title")
            guard let resultUrl = try resultLink.first()?.select("a").first()?.attr("href") else {return nil}  //TODO throw error
            
            if try! validateSong(songUrl: resultUrl) {
                return resultUrl
            }
            
            resultIndex += 1
        }

        return nil
        
    }

    func obtainMusicSearchUrl(musicName: String) -> String {
        
        func formatStringToUrlFormat(stringUrl: String) -> String {
            return String(describing: stringUrl.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!)
        }
        
        return self.originUrl + "/?q=\(formatStringToUrlFormat(stringUrl: musicName))"
    }
    
    func addURLParameters(urlString: String) -> String {
        var modifiedUrl : String = urlString + "#"
        
        if(self.bodyDiagrams || self.twoColumns){
            if(twoColumns){
                modifiedUrl += "columns=\(self.twoColumns)" + (self.bodyDiagrams ? "&" : "")
            }else if(bodyDiagrams){
                modifiedUrl += "bodyChords=\(self.bodyDiagrams)"
            }
        }
        
        return modifiedUrl + "&footerChords=\(self.footerChords)&tabs=\(self.tabs)"
    }
    
    func validateSong(songUrl: String) throws -> Bool {
        do {
            let content = try String(contentsOf:URL(string: songUrl)!)
            let urlDocument : SwiftSoup.Document = try! SwiftSoup.parse(content)
            
            return (try? urlDocument.getElementsByClass("cifra_cnt g-fix cifra-mono").first()) != nil
        }
        catch{
            throw URLException.cannotLoad
        }
    }
}
