//
//  PokemonDetail.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 22/06/22.
//

import SwiftUI

struct PokemonDetail: View {
    
    @ObservedObject var networkVM: NetworkManager
    var url : String
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                //MARK: - HEADER
                VStack {
                    ZStack {
                        Color.blue.opacity(0.6).ignoresSafeArea(.all)
                        Image("ditto")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200,alignment: .center)
                    }
                }
                .frame(height: geo.size.height * 0.3)
                
                //MARK: - BOTTOM
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(networkVM.pokemon.name.capitalized)
                                .font(.largeTitle)
                            Spacer()
                            ForEach (networkVM.pokemon.types, id:\.self) { type in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 30)
                                        .foregroundColor(.gray)
                                        .frame(width: 100, height: 30)
                                    Text(type.type.name.capitalized)
                                }
                            }
                        }
                        Text("It is described in mythology as the Pokémon that shaped the universe with its 1,000 arms.")
                        
                        Text("Moves")
                            .font(.title2)
                            .padding(.top,5)
                        Spacer()
                    }
                }
                .padding(.horizontal,10)
            }
            //                .background(.red)
        }
        .onAppear {
            networkVM.fetchPokemon(url: URL(string: url) ?? URL(fileURLWithPath: ""))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("#453")
            }
        }
    }
}


struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(networkVM: NetworkManager(), url: "https://pokeapi.co/api/v2/pokemon/13/")
    }
}
