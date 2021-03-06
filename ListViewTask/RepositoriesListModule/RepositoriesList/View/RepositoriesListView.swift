import SwiftUI
import Combine

struct RepositoriesListView: View {
    
    @ObservedObject var viewModel = RepositoriesListViewModel()
    @State private var showCancelButton: Bool = false
    
    var body: some View {
        LoadingView(isShowing: .constant($viewModel.isShowLoader.wrappedValue)) {
            NavigationView {
                Group {
                    VStack {
                        // Search view
                        HStack {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                TextField("search", text: self.$viewModel.searchTerm, onEditingChanged: { isEditing in
                                    self.viewModel.searchRepositoriesList()
                                    self.showCancelButton = true
                                }, onCommit: {
                                    self.viewModel.searchRepositoriesList()
                                    self.showCancelButton = true
                                }).foregroundColor(.primary)
                                
                                Button(action: {
                                    UIApplication.shared.endEditing(true)
                                    self.viewModel.searchTerm = ""
                                    self.viewModel.searchRepositoryList.removeAll()
                                    self.showCancelButton = false
                                }) {
                                    Image(systemName: "xmark.circle.fill").opacity(self.viewModel.searchTerm == "" ? 0 : 1)
                                }
                            }
                            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                            .foregroundColor(.secondary)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10.0)
                            
                            if self.showCancelButton  {
                                Button("Cancel") {
                                    UIApplication.shared.endEditing(true)
                                    self.viewModel.searchTerm = ""
                                    self.viewModel.searchRepositoryList.removeAll()
                                    self.showCancelButton = false
                                }
                                .foregroundColor(Color(.systemBlue))
                            }
                        }
                        .padding(.horizontal)
                        .navigationBarHidden(self.showCancelButton)
                        List(self.viewModel.searchRepositoryList.isEmpty ? self.viewModel.repositoryList : self.viewModel.searchRepositoryList ) { item in
                            RepositoriesListViewCell(name: item.name, item: item.owner, id: item.id)
                        }
                        .navigationBarTitle("Github Repositories")
                        .resignKeyboardOnDragGesture()
                    }
                    
                }}
                .onAppear {
                    self.viewModel.getRepositoriesList()
                }
        }.alert(isPresented: $viewModel.isShowAlert) {
            Alert(
                title: Text(""),
                message: Text($viewModel.alertMessage.wrappedValue),
                primaryButton: .destructive(Text("Retry"), action: {
                    UIApplication.shared.endEditing(true)
                    self.viewModel.searchTerm = ""
                    self.viewModel.getRepositoriesList()
                    self.viewModel.searchRepositoryList.removeAll()
                }),
                secondaryButton: .default(Text("Cancel"), action: {
                    // do something
                })
            )
        }
        
    }
}

struct RepositoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesListView()
    }
}
