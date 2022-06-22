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
            errorMessage = NetworkError.badUrl.localizedDescription
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse,!(200...299).contains(response.statusCode) {
                DispatchQueue.main.async {
                    self.errorMessage = NetworkError.response(statusCode: response.statusCode).localizedDescription
                    print(NetworkError.response(statusCode: response.statusCode))
                }
            } else if let error = error as? URLError {
                DispatchQueue.main.async {
                    self.errorMessage = NetworkError.urlSession(error).localizedDescription
                    print(NetworkError.urlSession(error))
                }
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let pokemons = try decoder.decode(Result.self, from: data)
                    //                    print(pokemons)
                    DispatchQueue.main.async {
                        self.allPokemons = pokemons.results
                    }
                }catch {
                    self.errorMessage = NetworkError.parsing(error as? DecodingError).localizedDescription
                    print(NetworkError.parsing(error as? DecodingError))
                }
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        task.resume()
    }
}
