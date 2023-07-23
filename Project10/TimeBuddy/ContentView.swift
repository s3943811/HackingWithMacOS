//
//  ContentView.swift
//  TimeBuddy
//
//  Created by Maximus Dionyssopoulos on 23/7/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var timeZones = [String]()
    @State private var newTimeZone = "GMT"
    @State private var selectedTimeZones = Set<String>()
    @State private var id = UUID()
    @State private var alreadyAddedAlert = false
    @State private var userWantsToQuit = false
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func timeData(for zoneName: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.timeZone = TimeZone(identifier: zoneName) ?? .current
        return "\(zoneName): \(dateFormatter.string(from: .now))"
    }
    
    func load() {
        timeZones = UserDefaults.standard.stringArray(forKey: "TimeZones") ?? []
    }
    func save() {
        UserDefaults.standard.set(timeZones, forKey: "TimeZones")
    }
    func deleteItems() {
        withAnimation {
            timeZones.removeAll(where: selectedTimeZones.contains)
        }
        save()
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        timeZones.move(fromOffsets: source, toOffset: destination)
        save()
    }
    
    func quit() {
        NSApp.terminate(nil)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    userWantsToQuit = true
                } label: {
                    Label("Quit", systemImage: "xmark.circle.fill")
                        .labelStyle(.iconOnly)
                        
                }
                .foregroundColor(.secondary)
                .alert(isPresented: $userWantsToQuit) {
                    Alert(title: Text("Are you sure you want to quit?"),
                          primaryButton: .default(Text("Quit")) {
                        quit()
                    },
                          secondaryButton: .cancel(Text("Cancel")) {
                        userWantsToQuit = false
                    }
                    )
                }
            }
            .buttonStyle(.plain)
            if timeZones.isEmpty {
                Text("Please add your first time zone below")
                    .frame(maxHeight: .infinity)
            } else {
                List(selection: $selectedTimeZones) {
                    ForEach(timeZones, id: \.self) { timeZone in
                        let time = timeData(for: timeZone)
                        HStack {
                            Text(time)
                            Button {
                                NSPasteboard.general.clearContents()
                                NSPasteboard.general.setString(time, forType: .string)
                            } label: {
                                Label("Copy", systemImage: "doc.on.doc")
                                    .labelStyle(.iconOnly)
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                    .onMove(perform: moveItems)
                }
                .onDeleteCommand(perform: deleteItems)
                .contextMenu {
                    Button("Delete") {
                        deleteItems()
                    }
                }
                .contextMenu(forSelectionType: String.self, menu: {_ in}) { timeZones in
                    NSPasteboard.general.clearContents()
                    
                    let timeData = timeZones.map(timeData).sorted().joined(separator: "\n")
                    NSPasteboard.general.setString(timeData, forType: .string)
                }
            }
            Divider()
            HStack {
                Picker("Add Time Zone:", selection: $newTimeZone) {
                    ForEach(TimeZone.knownTimeZoneIdentifiers, id:  \.self) {  timeZone in
                        Text(timeZone)
                    }
                }
                
                Button("Add") {
                    if timeZones.contains(newTimeZone) == false {
                        withAnimation {
                            timeZones.append(newTimeZone)
                        }
                        save()
                    }
                    else {
                        alreadyAddedAlert = true
                    }
                }
                .buttonStyle(.borderedProminent)
                .id(id)
                .alert(isPresented: $alreadyAddedAlert) {
                    Alert(title: Text("Error!"),
                          message: Text("You have already selected \(newTimeZone)\nPlease select another option."),
                          dismissButton: .default(Text("Ok"))
                    )
                }
                
            }
        }
        .padding()
        .onAppear(perform: load)
        .frame(height: 300)
        .onReceive(timer) {_ in
            if NSApp.keyWindow?.isVisible == true && !alreadyAddedAlert {
                id = UUID()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
