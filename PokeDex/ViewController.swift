//
//  ViewController.swift
//  PokeDex
//
//  Created by Cambrian on 2022-01-20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pokeName: UILabel!
    
    var pokeList = [Pokemon]()
    
    @IBAction func reloadData(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        PokeAPIHelper.fetch { pokeList in
            self.pokeName.text = pokeList[0].name
        }
    }


}

