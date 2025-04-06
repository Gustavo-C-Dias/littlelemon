import SwiftUI

struct Header: View {
    @State var isLoggedIn = false

    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 70)
            }
        }
        .frame(maxHeight: 60)
        .padding(.bottom)
        .onAppear() {
            if UserDefaults.standard.bool(forKey: keyIsLoggedIn) {
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
        }
    }
}
