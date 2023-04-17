//
//  DataController.swift
//  final-year-capstone
//
//  Created by Michael Wang on 2023-02-16.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "PatientModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved.")
        } catch {
            print("Failed to save data.")
        }
    }
    
    func addPatient(first_name: String, last_name: String, notes: String, file_url: URL, context: NSManagedObjectContext) {
        let patient = Patient(context: context)
        patient.id = UUID()
        patient.date = Date()
        patient.first_name = first_name
        patient.last_name = last_name
        patient.notes = notes
        patient.file_url = file_url
        
        save(context: context)
    }
    
    func editPatient(patient: Patient, first_name: String, last_name: String, notes: String, context: NSManagedObjectContext) {
        patient.notes = notes
        patient.last_name = last_name
        patient.first_name = first_name
        
        save(context: context)
    }
}
