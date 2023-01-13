//
//  MovieDetailView.swift
//  CoreDataTutorial
//
//  Created by paige shin on 2023/01/13.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: Movie
    @State private var movieName: String = ""
    let coreDM: CoreDataManager
    @Binding var needsRefresh: Bool
    
    var body: some View {
        VStack {
            TextField(self.movie.title ?? "", text: self.$movieName)
                .textFieldStyle(.plain)
            Button("Update") {
                if !self.movieName.isEmpty {
                    self.movie.title = self.movieName
                    self.coreDM.updateMovie()
                    self.needsRefresh.toggle()
                }
            }
        } //: VSTACK
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie(), coreDM: CoreDataManager(), needsRefresh: .constant(true))
    }
}
