import Foundation
import ArgumentParser
import CifraClubChords

struct Sifr : ParsableCommand {
    
    static let configuration = CommandConfiguration(
        abstract: "Browse your tabs and edit them easily",
        usage: "$> sifr <your music>",
        
        subcommands: [CifraClub.self],
        defaultSubcommand: CifraClub.self
    )
    
}

extension Sifr {
    
    struct CifraClub : ParsableCommand{
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

            let cifraClubTabs = Chords(
                musicName: musicName,
                tabs: tabs,
                twoColumns: split,
                bodyDiagrams: diagramChords,
                footerChords: !removeFooterChords
            )

            cifraClubTabs.searchMusic()
        }
    }
}
