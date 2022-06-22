//
//  NetworkManager.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 20/06/22.
//

import Foundation

class NetworkManager : ObservableObject {
    
    @Published var pokemon : Pokemon = defaultPokemon
    @Published var allPokemons = [Info]()
    
    @Published var errorMessage: String?
    @Published var errorMessageDetail: String?
    @Published var isLoading: Bool = false
    @Published var isLoadingDetail: Bool = false
    
    init(){
        fetchAllPokemons()
    }
    
    func fetchAPI<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping(Result<T,NetworkError>) -> Void) {
        
        guard let url = url else {
            let error = NetworkError.badUrl
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse,!(200...299).contains(response.statusCode) {
                completion(Result.failure(NetworkError.response(statusCode: response.statusCode)))
            } else if let error = error as? URLError {
                completion(Result.failure(NetworkError.urlSession(error)))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(type, from: data)
                    completion(Result.success(result))
                }catch {
                    completion(Result.failure(NetworkError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
    func fetchAllPokemons() {
        isLoading = true
        errorMessage = nil
        
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=2000&offset=0")
        
        fetchAPI(FetchResult.self, url: url, completion: {[unowned self] result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error.description)
                case .success(let allPokemons):
                    self.allPokemons = allPokemons.results
                }
            }
        })
    }
    
    func fetchPokemon(url: URL) {
        isLoadingDetail = true
        errorMessageDetail = nil
        
        fetchAPI(Pokemon.self, url: url, completion: {[unowned self] result in
            DispatchQueue.main.async {
                self.isLoadingDetail = false
                switch result {
                case .failure(let error):
                    self.errorMessageDetail = error.localizedDescription
                    print(error.description)
                case .success(let pokemon):
                    self.pokemon = pokemon
                }
            }
        })
        
        
    }
    
    //    func fetchAllPokemons() {
    //
    //        isLoading = true
    //
    //        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=2000&offset=0") else {
    //            errorMessage = NetworkError.badUrl.localizedDescription
    //            return
    //        }
    //
    //        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    //
    //            if let response = response as? HTTPURLResponse,!(200...299).contains(response.statusCode) {
    //                DispatchQueue.main.async {
    //                    self.errorMessage = NetworkError.response(statusCode: response.statusCode).localizedDescription
    //                    print(NetworkError.response(statusCode: response.statusCode))
    //                }
    //            } else if let error = error as? URLError {
    //                DispatchQueue.main.async {
    //                    self.errorMessage = NetworkError.urlSession(error).localizedDescription
    //                    print(NetworkError.urlSession(error))
    //                }
    //            } else if let data = data {
    //                let decoder = JSONDecoder()
    //
    //                do {
    //                    let pokemons = try decoder.decode(FetchResult.self, from: data)
    //                    //                    print(pokemons)
    //                    DispatchQueue.main.async {
    //                        self.allPokemons = pokemons.results
    //                    }
    //                }catch {
    //                    self.errorMessage = NetworkError.parsing(error as? DecodingError).localizedDescription
    //                    print(NetworkError.parsing(error as? DecodingError))
    //                }
    //            }
    //
    //            DispatchQueue.main.async {
    //                self.isLoading = false
    //            }
    //        }
    //        task.resume()
    //    }
}
