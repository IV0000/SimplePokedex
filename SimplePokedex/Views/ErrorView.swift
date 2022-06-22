//
//  ErroView.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 22/06/22.
//

import SwiftUI

struct ErrorView: View {
    
    var error : String
    
    var body: some View {
        VStack{
            Spacer()
            Text(error)
                .font(.system(size:20))
            Spacer()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: "Error")
    }
}
