//
//  PokemonDetail.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 22/06/22.
//

import SwiftUI

struct PokemonDetail: View {
    
    @ObservedObject var networkVM: NetworkManager
    var url: String
    
    var body: some View {
        
        VStack{
            if networkVM.isLoadingDetail {
                ProgressView()
            }
            else if networkVM.errorMessageDetail != nil {
                ErrorView(error: networkVM.errorMessageDetail ?? "An error occurred")
            }
            else{
                PokemonDetailSubView(networkVM: networkVM)
            }
        }
        .onAppear {
            networkVM.fetchPokemon(url: URL(string: url) ?? URL(fileURLWithPath: ""))
            networkVM.fetchSpeciesInfo(url: URL(string: networkVM.pokemon.species.url) ?? URL(fileURLWithPath: ""))
            networkVM.getDescription(lang: "en")
        }
    }
}

struct PokemonDetailSubView: View {
    
    @ObservedObject var networkVM: NetworkManager
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing:12) {
                //MARK: - HEADER
                HStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(typeColor(typeName: networkVM.pokemon.types.first?.type.name ?? "").opacity(0.15))
                        .frame(width: 280, height: 210)
                        .overlay{
                            AsyncImage(url: URL(string: networkVM.pokemon.sprites?.other?.officialArtwork?.frontDefault ?? "" )) { phase in
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
                                    Text("No image")
                                }
                            }
                        }
                    Spacer()
                    VStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(typeColor(typeName: networkVM.pokemon.types.first?.type.name ?? "").opacity(0.15))
                            .frame(width: 100, height: 100)
                            .overlay{
                                AsyncImage(url: URL(string: networkVM.pokemon.sprites?.frontDefault ?? "")) { phase in
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
                                        Text("No image")
                                    }
                                }
                            }
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(typeColor(typeName: networkVM.pokemon.types.first?.type.name ?? "").opacity(0.15))
                            .frame(width: 100, height: 100)
                            .overlay{
                                AsyncImage(url: URL(string: networkVM.pokemon.sprites?.backDefault ?? "")) { phase in
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
                                        Text("No image")
                                    }
                                }
                            }
                    }
                }
                //MARK: - BOTTOM
                VStack(alignment: .leading) {
                    HStack{
                        ForEach (networkVM.pokemon.types, id:\.self) { type in
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundColor(typeColor(typeName: type.type.name))
                                    .frame(width: 100, height: 30)
                                Text(type.type.name.capitalized)
                            }
                        }
                        Spacer()
                    }
                    Text(networkVM.description)
                    
                    Text("Moves")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.vertical,5)
                    Divider()
                    ForEach(networkVM.pokemon.moves,id:\.self) { move in
                        Text(move.move.name.capitalized)
                        Divider()
                    }
                    Spacer()
                }
            }
        }
        .padding(.vertical)
        .padding(.horizontal,12)
        .navigationTitle(networkVM.pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("#\(networkVM.pokemon.id)")
            }
        }
    }
    
    func typeColor (typeName: String) -> Color {
        return (TypeColor.init(rawValue: String(typeName)) ?? .normal).color
    }
}

//MARK: - PREVIEW
struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(networkVM: NetworkManager(), url: "https://pokeapi.co/api/v2/pokemon/13/")
    }
}
