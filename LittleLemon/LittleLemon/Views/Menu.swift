import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText: String = ""
    var body: some View {
        VStack {
            Text("Title")
            Text("Chicago")
            Text("Description")
            
            TextField("Search menu", text: $searchText)
            
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                List(dishes, id: \.id) { dish in
                    HStack {
                        Text("\(dish.title ?? "Sem título") - $\(dish.price ?? "0.0")")
                        
                        AsyncImage(url: URL(string: dish.image!)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
        }.onAppear {
            getMenuData()
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erro na requisição: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Dados inválidos")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(MenuList.self, from: data)
                let menuItems = decodedData.menu
                
                DispatchQueue.main.async {
                    let viewContext = PersistenceController.shared.container.viewContext
                    
                    for menuItem in menuItems {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                    }
                    
                    do {
                        try viewContext.save()
                        print("Dados salvos com sucesso!")
                    } catch {
                        print("Erro ao salvar no banco de dados: \(error.localizedDescription)")
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

#Preview {
    Menu()
}
