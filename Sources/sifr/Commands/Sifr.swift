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
