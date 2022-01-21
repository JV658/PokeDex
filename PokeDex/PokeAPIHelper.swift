//
//  PokeAPIHelper.swift
//  PokeDex
//
//  Created by Cambrian on 2022-01-20.
//

import Foundation

struct PokeAPIHelper{
    private static let baseURL = "https://pokeapi.co/api/v2/pokemon"
    
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    static func fetch(callback: @escaping ([Pokemon]) -> Void){
        guard
            let url = URL(string: baseURL)
        else{return}
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            data, request, error in
            
            if let data = data {
                do{
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])

                    guard
                        let jsonDictionary = jsonObject as? [AnyHashable: Any],
                        let results = jsonDictionary["results"] as? [[String:String]]
                    else{preconditionFailure("was not able to parse JSON data")}

                    var pokeList = [Pokemon]()
                    
                    for pokemon in results {
                        let newPokemon = Pokemon(name: pokemon["name"]!, url: pokemon["url"]!)
                        pokeList.append(newPokemon)
                    }
                    

                    
                    OperationQueue.main.addOperation {
                        callback(pokeList)
                    }
                    
                } catch let e {
                    print("could not serialize json data \(e)")
                }
            } else if let error = error {
                print("something went wrong when fetching. ERROR \(error)")
            } else {
                print("unknown error has occured")
            }
            
        }
        task.resume()
    }
}
