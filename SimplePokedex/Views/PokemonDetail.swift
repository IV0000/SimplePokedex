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
        
        VStack{
        if networkVM.isLoadingDetail {
            ProgressView()
        }
        else if networkVM.errorMessageDetail != nil {
            ErrorView(error: networkVM.errorMessageDetail ?? "An error occurred")
        }
        else{
            VStack(spacing:12) {
                //MARK: - HEADER
                HStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.primary.opacity(0.2))
                        .frame(width: 270, height: 210)
                        .overlay{
                            AsyncImage(url: URL(string: networkVM.pokemon.sprites.other.officialArtwork.frontDefault)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 200,alignment: .center)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                                else if phase.error != nil {
                                    ProgressView()
                                }
                                else {
                                    //No image
                                    ProgressView()
                                }
                            }
                        }
                    Spacer()
                    VStack{
                       RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.primary.opacity(0.2))
                            .frame(width: 100, height: 100)
                            .overlay{
                                AsyncImage(url: URL(string: networkVM.pokemon.sprites.frontDefault)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 90, height: 90,alignment: .center)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                                    else if phase.error != nil {
                                        ProgressView()
                                    }
                                    else {
                                        //No image
                                        ProgressView()
                                    }
                                }
                            }
                       RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.primary.opacity(0.2))
                            .frame(width: 100, height: 100)
                            .overlay{
                                AsyncImage(url: URL(string: networkVM.pokemon.sprites.backDefault)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 90, height: 90,alignment: .center)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                                    else if phase.error != nil {
                                        ProgressView()
                                    }
                                    else {
                                        //No image
                                        ProgressView()
                                    }
                                }
                            }
                    }
                }
                //MARK: - BOTTOM
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        HStack{
                            ForEach (networkVM.pokemon.types, id:\.self) { type in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 30)
                                        .foregroundColor(.gray)
                                        .frame(width: 100, height: 30)
                                    Text(type.type.name.capitalized)
                                }
                            }
                            Spacer()
                        }
                        Text("It is described in mythology as the Pokémon that shaped the universe with its 1,000 arms.")
                        
                        Text("Moves")
                            .font(.title2)
                            .padding(.top,5)
                        Spacer()
                    }
                }
                
            }
            .padding(.vertical)
            .padding(.horizontal,12)
            .navigationTitle(networkVM.pokemon.name.capitalized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("#\(networkVM.pokemon.id)")
                }
            }
            
        }
        }
        .onAppear {
            networkVM.fetchPokemon(url: URL(string: url) ?? URL(fileURLWithPath: ""))
        }
    }
}


struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(networkVM: NetworkManager(), url: "https://pokeapi.co/api/v2/pokemon/13/")
    }
}
