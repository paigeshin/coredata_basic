//
//  ContentView.swift
//  CoreDataTutorial
//
//  Created by paige shin on 2023/01/12.
//

import SwiftUI

struct ContentView: View {
    
    let coreDM: CoreDataManager
    @State private var movieName: String = ""
    @State private var movies: [Movie] = [Movie]()
    @State private var needsRefresh: Bool = false
    
    private func populateMovies() {
        self.movies = self.coreDM.getAllMovies()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter move name", text: self.$movieName)
                    .textFieldStyle(.roundedBorder)
                Button("Save") {
                    self.coreDM.saveMovie(title: self.movieName)
                    self.populateMovies()
                    self.movieName = ""
                }
                List {
                    ForEach(self.movies, id: \.self) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie,
                                            coreDM: self.coreDM,
                                            needsRefresh: self.$needsRefresh)
                        } label: {
                            Text(movie.title ?? "")
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let movie = self.movies[index]
                            self.coreDM.deleteMovie(movie: movie)
                            self.populateMovies()
                        }
                    }
                }
                .listStyle(.plain)
                .accentColor(self.needsRefresh ? .white : .black)
                Spacer()
            } //: VSTACK
            .padding()
            .onAppear {
                self.populateMovies()
            }
        } //: NAVIGATION VIEW
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
