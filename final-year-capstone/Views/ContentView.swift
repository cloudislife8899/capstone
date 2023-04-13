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
    @State private var isEditMode = false
    
    let image = Image("logo")

    var body: some View {
        NavigationView {
            VStack(spacing: 0.0) {
                HStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    Text("NaSYM Surgical")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .padding(.vertical)
                }
                
                if patient.isEmpty {
                    Spacer()
                    Text("Currently no patient data, please add a new patient profile.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Spacer()
                    
                } else {
                    List {
                        Section(header: Text("Past Patient Profiles")
                            .padding(.top)) {
                            ForEach(patient) { patient in
                                NavigationLink(destination: EditPatientView(patient: patient)) {
                                    HStack {
                                        Text("\(patient.first_name!) \(patient.last_name!)")
                                    }
                                }
                            }
                            .onDelete(perform: deletePatient)
                        }
                        .headerProminence(.increased)
                        
                    }
                    .listStyle(.automatic)

                }
                Button(action: {
                    showingAddView.toggle()
                }) {
                    Text("Add New Patient Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.all)
                .disabled(isEditMode)
                
            
                if !patient.isEmpty {
                    Button(action: {
                        isEditMode.toggle()
                    }) {
                        EditButton()
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            
            .fullScreenCover(isPresented: $showingAddView) {
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
