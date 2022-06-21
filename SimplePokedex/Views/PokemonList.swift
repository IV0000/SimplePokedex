//
//  ContentView.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 20/06/22.
//

import SwiftUI

struct PokemonList: View {
    
    var result: [Info]
    
    var body: some View {
        
        List{
            ForEach(result,id:\.self){ pokemon in
                Text(pokemon.name.capitalized)
                    
            }
        }.listStyle(.inset)
    
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList(result: dummyPokemon1)
    }
}
