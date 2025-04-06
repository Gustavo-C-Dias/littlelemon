import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            VStack {
                Banner()
                TextField("Search menu", text: $searchText)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .foregroundColor(Color.neutral2)
                    .cornerRadius(8)
                    .padding()
            }.background(Color.primary1)
            
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                List(dishes) { dish in
                    ItemFood(dish: dish)
                }
            }
        }.onAppear {
            getMenuData()
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")
        let request = URLRequest(url: url!)
        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Dados inválidos: \(error?.localizedDescription ?? "Erro desconhecido")")
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(MenuList.self, from: data)
                let menuItems = decodedData.menu
                let viewContext = PersistenceController.shared.container.viewContext

                DispatchQueue.main.async {
                    for item in menuItems {
                        let dish = Dish(context: viewContext)
                        dish.title = item.title
                        dish.image = item.image
                        dish.price = item.price
                    }

                    do {
                        try viewContext.save()
                    } catch {
                        print("Erro ao salvar no CoreData: \(error.localizedDescription)")
                    }
                }

            } catch {
                print("Erro ao decodificar os dados: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedStandardCompare)
            )
        ]
    }
    
    func buildPredicate() -> NSPredicate{
        if (searchText.isEmpty) {
           return NSPredicate(value: true)
        }
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
}
