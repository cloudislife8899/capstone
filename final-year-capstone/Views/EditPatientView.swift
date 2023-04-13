//
//  EditPatientView.swift
//  final-year-capstone
//
//  Created by Michael Wang on 2023-03-09.
//

import SwiftUI

struct EditPatientView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var patient: FetchedResults<Patient>.Element
    
    @State private var showingConfirmationAlert = false
    
    @State private var first_name = ""
    @State private var last_name = ""
    @State private var notes = ""
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                Text("NaSYM Surgical")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .padding(.vertical)
            }
            .padding(.horizontal)
            
            Form {
                Section(header: Text("First Name")) {
                    TextField("First Name", text: $first_name)
                        .onAppear {
                            first_name = patient.first_name!
                        }
                }
                
                Section(header: Text("Last Name")) {
                    TextField("Last Name", text: $last_name)
                        .onAppear {
                            last_name = patient.last_name!
                        }
                }
                
                Section(header: Text("Notes")) {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                        .onAppear {
                            notes = patient.notes ?? ""
                        }
                }
                
            }
            
            HStack(spacing: 10) {
                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                .padding([.top, .leading])
                .frame(maxWidth: .infinity / 2)
                
                Button(action: {
                    showingConfirmationAlert = true
                }) {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding([.top, .trailing])
                .frame(maxWidth: .infinity / 2)
            }
            .alert(isPresented: $showingConfirmationAlert) {
                Alert(
                    title: Text("Save Changes?"),
                    message: Text("Are you sure you want to save these changes?"),
                    primaryButton: .default(Text("Save")) {
                        DataController().editPatient(patient: patient, first_name: first_name, last_name: last_name, notes: notes, context: managedObjContext)
                        dismiss()
                    },
                    secondaryButton: .cancel(Text("Cancel"))
                )
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
