//
//  PostListView.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 30/5/23.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject var viewModel = PostListViewModel()
    
    @State private var searchText = ""
    
    @State private var presentCreateAlert = false
    @State private var newPostTitle: String = ""
    @State private var newPostDescription: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                if viewModel.postList.count > 0 {
                    ForEach(viewModel.postList, id: \.id) { post in
                        PostRowView(title: post.title, description: post.dscription)
                    }
                    .onDelete(perform: viewModel.deletePost)
                } else {
                    Text("No Posts!")
                        .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Post") {
                        presentCreateAlert = true
                    }
                }
                ToolbarItem(placement: .navigation) {
                    Text("Posts")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) { _ in viewModel.search(matching: searchText) }
        }
        .alert("New Post", isPresented: $presentCreateAlert, actions: {
            TextField("Title", text: $newPostTitle)
            TextField("Description", text: $newPostDescription)

            Button("Save", action: {
                if !newPostTitle.isEmpty && !newPostDescription.isEmpty {
                    viewModel.addPost(title: newPostTitle, description: newPostDescription)
                    newPostTitle = ""
                    newPostDescription = ""
                }
            })
            
            Button("Cancel", role: .cancel, action: {
                presentCreateAlert = false
            })
        }, message: {
            Text("Please enter the title and a brief description for your post.")
        })
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
