import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation

    let firstName = UserDefaults.standard.string(forKey: keyFirstName) ?? ""
    let lastName = UserDefaults.standard.string(forKey: keyLastName) ?? ""
    let email = UserDefaults.standard.string(forKey: keyEmail) ?? ""

    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            
            Text(firstName)
            Text(lastName)
            Text(email)
            
            Button(action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                presentation.wrappedValue.dismiss()
            }) {
                Text("Logout")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
            
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
