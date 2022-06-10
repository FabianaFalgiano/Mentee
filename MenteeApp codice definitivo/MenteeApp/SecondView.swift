//
//  SecondView.swift
//  Mentee
//
//  Created by Fabiana Falgiano on 22/11/21.
//

import SwiftUI
import CoreData

struct SecondView : View {
    
    @State private var change2 = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: ListModel.entity(),
                  sortDescriptors: [],animation: .default)
    private var taskList: FetchedResults<ListModel>
    
    var body: some View { Text("To Do, Done")
        
        NavigationView{
            List {
                ForEach (taskList) {
                    item in NavigationLink {
                        
                        Text("\(item.title!)")
                        
                        
                    } label: {Text("\(item.title!)")}
                    
                }.onDelete(perform: deleteItems)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading){
                    
                    Button("Back"){
                        change2.toggle()}
                    .fullScreenCover(isPresented: $change2) {
                        ContentView()
                    }
                    
                }
            }
            
            
            
        }
        
        
    }
    private func addItem() {
        withAnimation {
            let newItem = ListModel(context: viewContext)
            
            newItem.title = "parola"
            
            
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
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
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}

