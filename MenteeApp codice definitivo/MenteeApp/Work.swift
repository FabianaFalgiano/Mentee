//
//  Work.swift
//  Mentee
//
//  Created by Fabiana Falgiano on 22/11/21.
//

import SwiftUI
import CoreData

struct Work: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: ListModel.entity(),
                  sortDescriptors: [],animation: .default)
    private var taskList: FetchedResults<ListModel>
    
    let title: String
    @State var actualView: String = "To do "
    @State var array = ["To do ", "Done"]
    @State var addRow: Bool = false
    func aggiungi() {
        addRow.toggle()
    }
    struct subtask {
        var title = ""
        var gesù = 33
    }
    var elementi: [subtask] = []
    var body: some View {
        
        VStack{
            
            Picker("", selection: $actualView){
                ForEach(array, id: \.self){
                    Text($0)
                    
                }
            }.pickerStyle(.segmented)
                .padding()
        }
        
        List {
            ForEach (taskList) {
                item in NavigationLink {
                    
                    Text("\(item.title!)")
                    
                    
                } label: {Text("\(item.title!)")}
                
            }.onDelete(perform: deleteItems)
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



