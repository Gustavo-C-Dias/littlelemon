import SwiftUI

let keyIsLoggedIn = "keyIsLoggedIn"
let keyFirstName = "key-first-name"
let keyLastName = "key-last-name"
let keyEmail = "key-email"

struct Onboarding: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var isLoggedIn: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    Header()
                    Banner()
                    
                    Spacer()
                                        
                    VStack(alignment: .leading, spacing: 16) {
                        Text("First Name").font(.regular())
                        TextField("Enter your first name", text: $firstName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Text("Last Name").font(.regular())
                        TextField("Enter your last name", text: $lastName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Text("Email").font(.regular())
                        TextField("Enter your email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button("Register", action: {
                            if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                                UserDefaults.standard.set(firstName, forKey: keyFirstName)
                                UserDefaults.standard.set(lastName, forKey: keyLastName)
                                UserDefaults.standard.set(email, forKey: keyEmail)
                                
                                isLoggedIn = true
                                UserDefaults.standard.set(isLoggedIn, forKey: keyIsLoggedIn)
                            }
                        })
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(Color.primary2)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                    }
                    .padding(.vertical, 40)
                    .padding(.horizontal, 20)
                                        
                }
                .navigationDestination(isPresented: $isLoggedIn) {
                    Home()
                }
                .onAppear {
                    if UserDefaults.standard.bool(forKey: keyIsLoggedIn) {
                        isLoggedIn = true
                    }
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
