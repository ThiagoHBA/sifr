//
//  File.swift
//  
//
//  Created by Thiago Henrique on 23/03/22.
//

import Foundation
import ArgumentParser
import CifraClubChords

extension Sifr {
    
    struct CifraClub : ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Search for tabs in cifra club web site"
        )
        
        @Argument(help: "The name of the music to search")
        var musicName: String
    
        @Flag(help: "Show tabs in music website")
        var tabs: Bool = false
        
        @Flag(help: "Split the website tabs in two columns")
        var split: Bool = false
        
        @Flag(help: "Show diagrams chords in middle of tabs")
        var diagramChords: Bool = false
        
        @Flag(help: "Disable Footer chords in website tabs")
        var removeFooterChords : Bool = false
        
        func run() throws {

            let cifraClubChords = Chords(
                musicName: musicName,
                tabs: tabs,
                twoColumns: split,
                bodyDiagrams: diagramChords,
                footerChords: !removeFooterChords
            )

            cifraClubChords.searchMusic()
        }
    }
}
