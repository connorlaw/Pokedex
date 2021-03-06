//
//  ViewController.swift
//  Pokedex
//
//  Created by LAW on 18/10/2017.
//  Copyright © 2017 LAW. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV() {
       
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        // 1. this creates a path to the pokemon.csv file
        
        do {
            
            // 2. using the parser to pull out the rows
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            // 3. for each row we get the pokeid and the name
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                // 4. create a pokemon object every time and pass it into the array
                let poke = Pokemon(name: name, pokedexID: pokeID)
                pokemon.append(poke)
            }
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
                
            } else {
                
               poke = pokemon[indexPath.row]
                cell.configureCell(poke)
                
            }
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("work")
        var poke: Pokemon!
        
        if inSearchMode {
            
            poke = filteredPokemon[indexPath.row]
            
        } else {
            
            poke = pokemon[indexPath.row]
            
        }
        print("FINAL SteP")
        performSegue(withIdentifier: "PokemonDetailViewController", sender: poke)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            
            return filteredPokemon.count
            
        } else {
            
            return pokemon.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

    @IBAction func musicButtonPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
            
        } else {
            
            musicPlayer.play()
            sender.alpha = 1.0
            
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonDetailViewController" {
            print("the segue identifier is correct")
            if let detailsViewController = segue.destination as? PokemonDetailViewController {
                print("the segue destination is correct")
                if let poke = sender as? Pokemon {
                    print("the sender is a pokemon")
                    detailsViewController.pokemon = poke
                    print(poke.name)
                }
            }
            
        }
    }
    
}













