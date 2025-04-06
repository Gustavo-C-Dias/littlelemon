import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation

    let firstName = UserDefaults.standard.string(forKey: keyFirstName) ?? ""
    let lastName = UserDefaults.standard.string(forKey: keyLastName) ?? ""
    let email = UserDefaults.standard.string(forKey: keyEmail) ?? ""
        
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                HStack {
                    Image("profile-image-placeholder")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(maxHeight: 75)
                        .clipShape(Circle())
                        .padding(.trailing)
                    
                    VStack (spacing: 5) {
                        Text(firstName).font(.regularBold())
                        Text(lastName).font(.caption())
                    }
                }.padding()

                
                Button("Logout", action: {
                    UserDefaults.standard.set(false, forKey: keyIsLoggedIn)
                    presentation.wrappedValue.dismiss()
                })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primary2)
                    .foregroundColor(Color.neutral2)
                    .cornerRadius(10)
                    .padding()
                
                Spacer()
            }
        }
        .navigationTitle(Text("Personal information"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserProfile()
}
