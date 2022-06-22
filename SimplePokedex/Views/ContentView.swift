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
            ErrorView(networkVM: networkVM)
        }
        else {
            PokemonList(networkVM: networkVM)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
