//
//  AlarmTimelineView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 28.05.22.
//

import SwiftUI

struct AlarmTimelineView: View {
    var alarms: [LDAlarm]
    
    
    var body: some View {
        ZStack {
            line().stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round)).fill(.quaternary)
            dots(alarms: alarms).fill(.teal)
            Label(alarms.first!.date.toString()!, systemImage: "").position(x: 180, y: 70)
        }.frame(width: 200, height: 600)
    }
}

struct AlarmTimelineView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmTimelineView(alarms: [LDAlarm(fromNow: 9.hours), LDAlarm(fromNow: 8.hours)])
    }
}

struct dots: Shape {
    
    var alarms: [LDAlarm] = []
    
    func calculateEllipses(alarms: [LDAlarm], rect: CGRect) -> [CGRect] {
        var rects: [CGRect] = []
        let stepSize: Double = rect.height / 100.0 * 10.0
        print(stepSize)
        for i in 1...alarms.count {
            rects.append(CGRect(x: rect.midX - 12.5, y: rect.minY + stepSize * Double(i), width: 25, height: 25))
        }
        return rects
    }
    
    func path(in rect: CGRect) -> Path {
        let rects = calculateEllipses(alarms: alarms, rect: rect)
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        for rect in rects {
            path.addEllipse(in: rect)
        }
        return path
    }
}

struct line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}
