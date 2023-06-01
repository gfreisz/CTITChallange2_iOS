//
//  PostRowView.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 30/5/23.
//

import SwiftUI

struct PostRowView: View {
    @State var title: String
    @State var description: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.regular)
                Spacer()
            }
            HStack{
                Text(description)
                    .font(.headline)
                    .fontWeight(.light)
                Spacer()
            }
        }
    }
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView(title: "Post name", description: "Post description")
    }
}
