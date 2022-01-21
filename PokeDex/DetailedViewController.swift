//
//  DetailedViewController.swift
//  PokeDex
//
//  Created by Cambrian on 2022-01-20.
//

import UIKit

class DetailedViewController: UIViewController {

    
    var url: String!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var abilties: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fetchPokemon(url: url) { pokemonResponse in
            
            switch pokemonResponse {
            case .success(let pokemon):
                self.name.text = pokemon.name
                self.height.text = String(pokemon.height)
                self.id.text = String(pokemon.id)
                self.abilties.text = pokemon.abilities[0].ability.name
            case .failure(let error):
                print(error)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
