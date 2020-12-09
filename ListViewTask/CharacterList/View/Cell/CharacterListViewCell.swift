import SwiftUI

struct CharacterListViewCell: View {
    var name:String
    var item: OwnerCharacter
    var id:Int
    var body: some View {
        NavigationLink(destination: CharacterListDetailsView(name: name, item: item, id: id)) {
            HStack(alignment: .center,spacing: 8, content: {
            UrlImageView(urlString: item.avatarUrl)
                .frame(width:85, height:90)
                .cornerRadius(15)
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                Text(item.login ?? "")
                Text(item.type ?? "")
            }
        }).padding(.all,2.0)
        }
    }
}

struct CharacterListViewCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListViewCell(name: "", item: OwnerCharacter(login: "", id: 0, avatarUrl: "", url: "", type: "", createdAt: ""), id: 0)
    }
}
