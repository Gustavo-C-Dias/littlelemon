import SwiftUI

struct ItemFood: View {
    
    let dish: Dish
    
    var body: some View {
        HStack {
            VStack {
                Text(dish.title ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.regularBold())
                    .foregroundColor(Color.neutral2)
                Spacer(minLength: 10)
                Text("$" + (dish.price ?? ""))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption())
                    .foregroundColor(Color.neutral2)
                    .monospaced()
            }
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 90, maxHeight: 90)
            .clipShape(Rectangle())
        }
        .padding(.vertical)
        .frame(maxHeight: 150)
    }
}
