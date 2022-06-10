//
//  ContentView.swift
//  Mentee
//
//  Created by Fabiana Falgiano on 22/11/21.
//

import SwiftUI
import CoreData


struct ContentView: View {
    
    @State private var change2 = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: ListModel.entity(),
                  sortDescriptors: [],animation: .default)
    private var taskList: FetchedResults<ListModel>
    @State var searchText = ""
    @State var searching = false
    @State var NomeCosa = ""
    @State var done = false
    
    var isDisabled : Bool {
        if NomeCosa.isEmpty {
            return true
        }
        return false
    }
    
    @State var opac = 1.0
    @State private var change = false
    @State var actualView: String = "To do "
    @State var array = ["To do ", "Done"]
    struct taskName: Identifiable, Hashable {
        let name: String
        let id = UUID()
    }
    
    
    
    
    @State private var myTasks = [
    ]
    
    
    var body: some View {
        
        NavigationView {
            
            
            ZStack{
                
                VStack() {
                    
                    
                    
                    
                    Picker("", selection: $actualView){
                        ForEach(array, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                        .padding()
                    
                    
                    TextField("insert task name and click +",text: $NomeCosa)
                    
                        .padding(0)
                        .frame(width: 360, height: 35, alignment: .center)
                        .padding(.leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    
                    
                    VStack{
                        
                        List {
                            
                            ForEach (taskList) {
                                item in
                                if(actualView=="To do "){
                                    if(!item.complete){
                                        HStack{
                                            Text("\(item.title!)")
                                            Toggle(isOn: Binding<Bool>(
                                                get: { item.complete },
                                                set: {
                                                    item.complete = $0
                                                    
                                                    if item.complete == true {
                                                        opac = 1.0
                                                        item.opa = opac
                                                    } else{ opac = 0.0
                                                        item.opa = opac
                                                    }
                                                    try? self.viewContext.save()
                                                }
                                            )
                                            )
                                            
                                            {
                                                Text("")
                                                
                                                
                                            }
                                            
                                        }
                                        
                                        .toggleStyle(CheckboxStyle())
                                        .padding(.trailing, 40)
                                        
                                    }
                                }else{
                                    if(item.complete){
                                        HStack{
                                            Text("\(item.title!)")
                                            Toggle(isOn: Binding<Bool>(
                                                get: { item.complete },
                                                set: {
                                                    item.complete = $0
                                                    if item.complete == true {
                                                        opac = 1.0
                                                        item.opa = opac
                                                    } else{ opac = 0.0
                                                        item.opa = opac
                                                    }
                                                    try? self.viewContext.save()
                                                }
                                            )
                                            )
                                            
                                            {
                                                Text("")
                                                
                                                
                                            }
                                            
                                        }
                                        .toggleStyle(CheckboxStyle())
                                        .padding(.trailing, 40)
                                    }
                                    
                                }
                                
                                
                            }.onDelete(perform: deleteItems)
                            
                            
                        }
                        
                    }
                    .toolbar{
                        ToolbarItemGroup(placement: .navigationBarLeading)
                        {
                            
                            EditButton()
                                .foregroundColor(.orange)
                            
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: addItem) {
                                Label("Add Item", systemImage: "plus")
                                    .foregroundColor(.orange)
                            }
                            .disabled(isDisabled)
                        }
                    }.navigationTitle("My Tasks")
                    
                    if searching {
                        Button("Back") {
                            searchText = ""
                            withAnimation {
                                searching = false
                                UIApplication.shared.dismissKeyboard()
                                
                            }
                        }
                    }
                    
                }.padding()
                
            }
            
            
            .gesture(DragGesture()
                        .onChanged({ _ in
                UIApplication.shared.dismissKeyboard()
            })
            )
        }
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { taskList[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = ListModel(context: viewContext)
            
            newItem.title = NomeCosa
            newItem.complete = false
            NomeCosa = ""
            
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            let model = taskList[index]
            viewContext.delete(model)
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    struct SearchBar: View {
        
        @Binding var searchText: String
        @Binding var searching: Bool
        
        var body: some View {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("LightGray"))
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search ..", text: $searchText) { startedEditing in
                        if startedEditing {
                            withAnimation {
                                searching = true
                            }
                        }
                    } onCommit: {
                        withAnimation {
                            searching = false
                        }
                    }
                }
                .foregroundColor(.gray)
                .padding(.leading, 13)
            }
            .frame(height: 40)
            .cornerRadius(13)
            .padding()
        }
    }
    
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct CheckboxStyle: ToggleStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        return HStack {
            
            configuration.label
            
            Spacer()
            
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        
    }
}
