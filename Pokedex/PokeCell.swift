//
//  PokeCell.swift
//  Pokedex
//
//  Created by LAW on 18/10/2017.
//  Copyright © 2017 LAW. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.uppercased()
        thumbImage.image = UIImage(named: "\(self.pokemon.pokedexID)")
        
        
    }
    
}
