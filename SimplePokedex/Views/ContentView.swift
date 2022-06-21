//
//  ContentView.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 21/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var networkVM = NetworkManager()
    
    var body: some View {
        
        if networkVM.isLoading {
            ProgressView()
        }
        else if networkVM.errorMessage != nil {
            Text("errore")
        }
        else {
            PokemonList(result: networkVM.allPokemons)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
