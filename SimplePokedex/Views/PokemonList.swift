//
//  ContentView.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 20/06/22.
//

import SwiftUI

struct PokemonList: View {
    
    @ObservedObject var networkVM: NetworkManager
    @State private var search = ""
    
    var filteredPokemon: [Info] {
        if selectedSort == 1 {
            return networkVM.allPokemons.sorted(by: >)
        }
        else if !search.isEmpty {
            return networkVM.allPokemons.filter {
                $0.name.capitalized.contains(search)
            }
        }
        else {
            return networkVM.allPokemons.sorted(by: <)
        }
    }
    
    var sortTypes = ["A-Z","Z-A",]
    @State private var selectedSort = 0
    
    var body: some View {
        NavigationView {
            VStack{
            List {
                ForEach(filteredPokemon,id:\.self) { pokemon in
                    NavigationLink(destination:PokemonDetail(networkVM: networkVM, url: pokemon.url)) {
                        Text(pokemon.name.capitalized)
                    }
                }
            }
            .listStyle(.plain)
            }
            .navigationTitle("Pokédex")
            .refreshable {
                networkVM.fetchAllPokemons()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker(selection: $selectedSort, label: Text("Sort")) {
                        ForEach(0..<sortTypes.count) {
                            Text(self.sortTypes[$0])
                        }
                    }
                }
            }
            .searchable(text: $search)
            .disableAutocorrection(true)
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList(networkVM: NetworkManager())
    }
}
