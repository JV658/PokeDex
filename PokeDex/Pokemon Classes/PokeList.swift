//
//  PokeList.swift
//  PokeDex
//
//  Created by Cambrian on 2022-01-20.
//

import Foundation

enum PokeListResult {
    case success([Poke])
    case failure(Error)
}

class PokeList: Codable {
    var next: String
    var results: [Poke]
}

struct Poke: Codable{
    var name: String
    var url: String
}


func fetchPokeList(callback: @escaping (PokeListResult) -> Void){
    PokeAPIHelper.fetch { fetchResult in
        switch fetchResult {
        case .success(let data):
            do{
                let decoder = JSONDecoder()
                let pokeList = try decoder.decode(PokeList.self, from: data)
                
                OperationQueue.main.addOperation {
                    callback(.success(pokeList.results))
                }
                
            } catch let e {
                print("could not parse json data \(e)")
            }
        case .failure(let error):
            print("there was an error fetchin information \(error)")
        }

    }
}
