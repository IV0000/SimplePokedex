//
//  ErroView.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 22/06/22.
//

import SwiftUI

struct ErrorView: View {
    
    @ObservedObject var networkVM: NetworkManager
    
    var body: some View {
        VStack{
            Text(networkVM.errorMessage ?? "An error occurred")
                .font(.system(size:20))
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(networkVM: NetworkManager())
    }
}
