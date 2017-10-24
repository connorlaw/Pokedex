//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by LAW on 19/10/2017.
//  Copyright © 2017 LAW. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: Pokemon!

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name.uppercased()
        
    }
    
}
