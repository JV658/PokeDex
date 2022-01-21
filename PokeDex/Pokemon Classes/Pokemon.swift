//
//  Pokemon.swift
//  PokeDex
//
//  Created by Cambrian on 2022-01-20.
//

import Foundation

enum PokemonResponse {
    case success(Pokemon)
    case failure(Error)
}

class Pokemon: Codable {
    var abilities: [Ability]
    var base_experience: Int
    var height: Int
    var id: Int
    var name: String

}

class Ability: Codable {
    var ability: ability
    var is_hidden: Bool
    var slot: Int
}


struct ability: Codable {
    var name: String
    var url: String
}


func fetchPokemon(url: String, callback: @escaping (PokemonResponse) -> Void){
    PokeAPIHelper.fetch(url: url) {
        fetchResult in
        switch fetchResult {
        case .success(let data):
            do{
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                
                OperationQueue.main.addOperation {
                    callback(.success(pokemon))
                }
            } catch let e {
                print("error parsing json data \(e)")
            }
        case .failure(let error):
            print("error while fetching information: \(error)")
        }
    }
}
