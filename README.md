# sifr

<img src="https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white">

## O que é sifr?

**sifr** é um programa que busca facilitar o acesso a diagramas musicais, como, partituras, cifras, tablaturas, além de permitir a edição de parâmetros do diagrama a partir de argumentos enviados ao programa. Por padrão ele possui compatibilidade com o site <a href="https://www.cifraclub.com.br">Cifra Club</a> e aceita argumentos como tom e desativar tablaturas, diagramas no fim da cifra.

## Como contribuir com esse repositório? 

Este repositório possui compatibilidade com **SPM** (Swift Package Manager), a contribuição pode ser feita a partir da adição de um .package ao arquivo `Package.swift`. Exemplo de utilização com a <a href="https://github.com/ThiagoHBA/cifra-club-chords-library">biblioteca Cifra Club</a>

### Adicionando em dependencies

```Swift

name: "sifr",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/ThiagoHBA/cifra-club-chords-library", branch: "master"),
        ...
    ],
```
### Adicionando no executável

```Swift
     .executableTarget(
            name: "sifr",
            dependencies: [
                .product(name: "CifraClubChords", package: "cifra-club-chords-library"),
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
```

Após a instalação da biblioteca ser feita com sucesso, adicione um novo sub comando na pasta de sub comandos referente ao novo módulo adicionado. Exemplo: 

<img width="246" alt="image" src="https://user-images.githubusercontent.com/56696275/160622552-9d3562dc-ae42-4955-bc0a-2de511a66d71.png">

```Swift 
import Foundation
import ArgumentParser
import CifraClubChords

extension Sifr {
    
    struct CifraClub : ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Search for tabs in cifra club web site"
        )
 }
 
```

## Como instalar e utilizar o sifr?

### Instalando
Utilizando o terminal na pasta em que deseja instalar o programa, use o comando:
* `git clone https://github.com/ThiagoHBA/sifr`

### Executando
Após a instalação ser efetuada, ainda no terminal, utilize o comando:
* `swift run sifr "<insira sua música>"`

Para duvidas em como utilizar os parâmetros para alterar os diagramas utilize: 
* `swift run sifr --help`

