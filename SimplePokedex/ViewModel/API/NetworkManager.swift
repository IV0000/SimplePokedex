//
//  NetworkManager.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 20/06/22.
//

import Foundation

class NetworkManager : ObservableObject {

    @Published var pokemon = [Pokemon]()
    @Published var allPokemons = [Info]()
    
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    init(){
        fetchAllPokemons()
    }

    func fetchAllPokemons() {
        
        isLoading = true
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=2000&offset=0") else {
            print("Invalid url...")
            return
        }
                
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let pokemons = try decoder.decode(Result.self, from: data)
                    print(pokemons)
                    DispatchQueue.main.async {
                        self.allPokemons = pokemons.results
                    }
                    
                }catch {
                    print(error)
                }
            }
        }
        task.resume()
        
    }
    
}
