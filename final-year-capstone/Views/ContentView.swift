//
//  ContentView.swift
//  final-year-capstone
//
//  Created by Michael Wang on 2023-02-16.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var patient: FetchedResults<Patient>
    
    @State private var showingAddView = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(patient) {
                        patient in
                        NavigationLink(destination: EditPatientView(patient: patient)) {
                            HStack {
                                Text("\(patient.first_name!) \(patient.last_name!)")
                            }
                        }
                    }
                    .onDelete(perform: deletePatient)
                }.listStyle(.plain)
            }
            .navigationTitle("NaSYMSurgical")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Patient", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddPatientView()
                
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func deletePatient(offsets: IndexSet) {
        withAnimation {
            offsets.map { patient[$0] }.forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
