//
//  Widget1.swift
//  Widget1
//
//  Created by Gregory Keeley on 9/16/20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct Widget1EntryView : View {
    @Environment(\.widgetFamily) var size
    var colors: [Color] = [ Color(red: 22 / 255, green: 28 / 255, blue: 34 / 255),
                            Color(red: 14 / 255, green: 67 / 255, blue: 41 / 255),
                            Color(red: 2 / 255, green: 109 / 255, blue: 50 / 255),
                            Color(red: 38 / 255, green: 166 / 255, blue: 65 / 255),
                            Color(red: 57 / 255, green: 211 / 255, blue: 83 / 255)]
    var gridItemLayout = [GridItem(.adaptive(minimum: 20))]
    var body: some View {
        switch size {
        case .systemSmall:
        LazyVGrid(columns: gridItemLayout, spacing: 10) {
            ForEach((0...30), id: \.self) {
                Image("")
                    .resizable()
                    .frame(minWidth: 10, maxWidth: 20, minHeight: 10, maxHeight: 20)
                    .background(colors[($0 + Int.random(in: 1...5)) % colors.count])
                    .cornerRadius(4.0)
            }
        }
        .padding(EdgeInsets(top: 50, leading: 10, bottom: 50, trailing: 10))
        case .systemMedium:
            LazyVGrid(columns: gridItemLayout, spacing: 0) {
                ForEach((0...90), id: \.self) {
                    Image("")
                        .frame(minWidth: 0, maxWidth: 20, minHeight: 20)
                        .background(colors[($0 + Int.random(in: 1...5)) % colors.count])
                }
            }
        case .systemLarge:
            LazyVGrid(columns: gridItemLayout, spacing: 0) {
                ForEach((0...365), id: \.self) {
                    Image("")
                        .frame(minWidth: 0, maxWidth: 20, minHeight: 20)
                        .background(colors[($0 + Int.random(in: 1...5)) % colors.count])
                }
            }
        @unknown default:
            fatalError("Widget size not available")
        }
    }
}

@main
struct Widget1: Widget {
    let kind: String = "Widget1"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Widget1EntryView()
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct Widget1_Previews: PreviewProvider {
    static var previews: some View {
        Widget1EntryView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
