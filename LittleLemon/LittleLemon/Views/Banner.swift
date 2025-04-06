import SwiftUI

struct Banner: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Little Lemon")
                        .foregroundColor(Color.primary2)
                        .font(.title())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Chicago")
                        .foregroundColor(Color.neutral1)
                        .font(.subtitle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("We are family owned Mediterranean restaurant focused on traditional recipes served with a modern twist")
                        .foregroundColor(Color.neutral1)
                        .font(.regular())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 5)
                }.padding([.top, .leading, .bottom], 20)
                Image("banner")
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .frame(maxWidth: 120, maxHeight: 140)
                    .clipShape(Rectangle())
                    .cornerRadius(16)
            }
        }
        .background(Color.primary1)
    }
}
