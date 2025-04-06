import SwiftUI

let kIsLoggedIn = "kIsLoggedIn"
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
            VStack {
                if !isLoggedIn {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 70)
                                        
                    VStack(alignment: .leading) {
                        Text("Little Lemon")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 40)
                            .foregroundColor(.yellow)
                        
                        Text("Chicago")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        Text("We are family owned Mediterranean restaurant focused on traditional recipes served with a modern twist")
                            .font(.body)
                            .padding(.top, 5)
                            .padding(.bottom, 40)
                            .foregroundColor(.white)

                    }
                    .background(Color(UIColor(red: 76/255, green: 93/255, blue: 88/255, alpha: 1.0)))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 25) {
                        VStack(alignment: .leading) {
                            Text("First Name")
                                .font(.headline)
                            
                            TextField("Enter your first name", text: $firstName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }

                        VStack(alignment: .leading) {
                            Text("Last Name")
                                .font(.headline)
                            
                            TextField("Enter your last name", text: $lastName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }

                        VStack(alignment: .leading) {
                            Text("Email")
                                .font(.headline)
                            
                            TextField("Enter your email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    Button(action: {
                        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                            UserDefaults.standard.set(firstName, forKey: keyFirstName)
                            UserDefaults.standard.set(lastName, forKey: keyLastName)
                            UserDefaults.standard.set(email, forKey: keyEmail)
                            isLoggedIn = true
                            UserDefaults.standard.set(isLoggedIn, forKey: kIsLoggedIn)
                        }
                    }) {
                        Text("Register")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor(red: 76/255, green: 93/255, blue: 88/255, alpha: 1.0)))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
