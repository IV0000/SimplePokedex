//
//  ContentView.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 20/06/22.
//

import SwiftUI

struct PokemonList: View {
    
    var result: [Info]
    @State private var search = ""
    
    var searchedPokemon: [Info] {
        if search.isEmpty {
            return result
        }
        else {
            return result.filter {
                $0.name.capitalized.contains(search)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchedPokemon,id:\.self) { pokemon in
                    NavigationLink(destination:EmptyView()) {
                        Text(pokemon.name.capitalized)
                    }
                }
            }
            .listStyle(.inset)
            .searchable(text: $search)
            .navigationTitle("Pokédex")
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList(result: dummyPokemon1)
    }
}
