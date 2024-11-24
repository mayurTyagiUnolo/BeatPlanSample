//
//  HorizonPicker.swift
//  BeatPlan
//
//  Created by Mayur Tyagi on 24/11/24.
//

import HorizonCalendar
import SwiftUI
import UIKit

struct AirbnbDateRangePicker: View {
    
    @Environment(\.dismiss) var dismiss
    var dateSelected: (String, String) -> Void
    
    // MARK: Lifecycle
    
    init(calendar: Calendar, monthsLayout: MonthsLayout, dateHandler: @escaping (String, String) -> Void) {
        self.calendar = calendar
        self.monthsLayout = monthsLayout
        self.dateSelected = dateHandler
        
        let startDate = calendar.date(from: DateComponents(year: 2024, month: 01, day: 01))!
        let endDate = calendar.date(byAdding: .year, value: 1, to: Date.init())!
        visibleDateRange = startDate...endDate
        
        monthDateFormatter = DateFormatter()
        monthDateFormatter.calendar = calendar
        monthDateFormatter.locale = calendar.locale
        monthDateFormatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "MMMM yyyy",
            options: 0,
            locale: calendar.locale ?? Locale.current)
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack{
                Button("cancel"){
                    dismiss()
                }
                
                Spacer()
                
                Button("Done"){
                    if let dateRange = selectedDayRange {
                         let dateFormatter = DateFormatter()
                         dateFormatter.dateFormat = "yyyy-MM-dd"
//                         dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensures consistent formatting
                         
                         let calendar = Calendar.current
                         if let startDate = calendar.date(from: dateRange.lowerBound.components),
                            let endDate = calendar.date(from: dateRange.upperBound.components) {
                             let startDateString = dateFormatter.string(from: startDate)
                             let endDateString = dateFormatter.string(from: endDate)
                             
                             dateSelected(startDateString, endDateString)
                         } else {
                             print("Failed to create dates from components.")
                         }
                     }
                     dismiss()
                }
                .fontWeight(.bold)
            }
            .padding()
            
            CalendarViewRepresentable(
                calendar: calendar,
                visibleDateRange: visibleDateRange,
                monthsLayout: monthsLayout,
                dataDependency: selectedDayRange,
                proxy: calendarViewProxy)
            
            .interMonthSpacing(24)
            .verticalDayMargin(8)
            .horizontalDayMargin(8)
            
            .monthHeaders { month in
                let monthHeaderText = monthDateFormatter.string(from: calendar.date(from: month.components)!)
                Group {
                    if case .vertical = monthsLayout {
                        HStack {
                            Text(monthHeaderText)
                                .font(.title2)
                            Spacer()
                        }
                        .padding()
                    } else {
                        Text(monthHeaderText)
                            .font(.title2)
                            .padding()
                    }
                }
                .accessibilityAddTraits(.isHeader)
            }
            
            .days { day in
                SwiftUIDayView(dayNumber: day.day, isSelected: isDaySelected(day))
            }
            
            .dayRangeItemProvider(for: selectedDateRanges) { dayRangeLayoutContext in
                let framesOfDaysToHighlight = dayRangeLayoutContext.daysAndFrames.map { $0.frame }
                // UIKit view
                
                return DayRangeIndicatorView.calendarItemModel(
                    invariantViewProperties: .init(),
                    content: .init(framesOfDaysToHighlight: framesOfDaysToHighlight))
            }
            
            .onDaySelection { day in
                DayRangeSelectionHelper.updateDayRange(
                    afterTapSelectionOf: day,
                    existingDayRange: &selectedDayRange)
            }
            
            .onMultipleDaySelectionDrag(
                began: { day in
                    DayRangeSelectionHelper.updateDayRange(
                        afterDragSelectionOf: day,
                        existingDayRange: &selectedDayRange,
                        initialDayRange: &selectedDayRangeAtStartOfDrag,
                        state: .began,
                        calendar: calendar)
                },
                changed: { day in
                    DayRangeSelectionHelper.updateDayRange(
                        afterDragSelectionOf: day,
                        existingDayRange: &selectedDayRange,
                        initialDayRange: &selectedDayRangeAtStartOfDrag,
                        state: .changed,
                        calendar: calendar)
                },
                ended: { day in
                    DayRangeSelectionHelper.updateDayRange(
                        afterDragSelectionOf: day,
                        existingDayRange: &selectedDayRange,
                        initialDayRange: &selectedDayRangeAtStartOfDrag,
                        state: .ended,
                        calendar: calendar)
                })
            
            .onAppear {
                calendarViewProxy.scrollToDay(
                    containing: calendar.date(from: DateComponents(year: 2024, month: 07, day: 19))!,
                    scrollPosition: .centered,
                    animated: false)
            }
            
            .frame(maxWidth: 375, maxHeight: .infinity)
        }
    }
    
    // MARK: Private
    
    private let calendar: Calendar
    private let monthsLayout: MonthsLayout
    private let visibleDateRange: ClosedRange<Date>
    
    private let monthDateFormatter: DateFormatter
    
    @StateObject private var calendarViewProxy = CalendarViewProxy()
    
    @State private var selectedDayRange: DayComponentsRange?
    @State private var selectedDayRangeAtStartOfDrag: DayComponentsRange?
    
    private var selectedDateRanges: Set<ClosedRange<Date>> {
        guard let selectedDayRange else { return [] }
        let selectedStartDate = calendar.date(from: selectedDayRange.lowerBound.components)!
        let selectedEndDate = calendar.date(from: selectedDayRange.upperBound.components)!
        return [selectedStartDate...selectedEndDate]
    }
    
    private func isDaySelected(_ day: DayComponents) -> Bool {
        if let selectedDayRange {
            return day == selectedDayRange.lowerBound || day == selectedDayRange.upperBound
        } else {
            return false
        }
    }
    
}

#Preview {
    AirbnbDateRangePicker(calendar: Calendar.current, monthsLayout: MonthsLayout.vertical(options: VerticalMonthsLayoutOptions()), dateHandler: { startDate, endDate in
        print(startDate, endDate)
    })
}


struct SwiftUIDayView: View {
    
    let dayNumber: Int
    let isSelected: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .strokeBorder(isSelected ? Color.accentColor : .clear, lineWidth: 2)
                .background {
                    Circle()
                        .foregroundColor(isSelected ? Color(UIColor.systemBackground) : .clear)
                }
                .aspectRatio(1, contentMode: .fill)
            Text("\(dayNumber)").foregroundColor(Color(UIColor.label))
        }
        .accessibilityAddTraits(.isButton)
    }
    
}


final class DayRangeIndicatorView: UIView {
    
    // MARK: Lifecycle
    
    fileprivate init(indicatorColor: UIColor) {
        self.indicatorColor = indicatorColor
        
        super.init(frame: .zero)
        
        backgroundColor = .clear
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal
    
    override func draw(_: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(indicatorColor.cgColor)
        
        if traitCollection.layoutDirection == .rightToLeft {
            context?.translateBy(x: bounds.midX, y: bounds.midY)
            context?.scaleBy(x: -1, y: 1)
            context?.translateBy(x: -bounds.midX, y: -bounds.midY)
        }
        
        // Get frames of day rows in the range
        var dayRowFrames = [CGRect]()
        var currentDayRowMinY: CGFloat?
        for dayFrame in framesOfDaysToHighlight {
            if dayFrame.minY != currentDayRowMinY {
                currentDayRowMinY = dayFrame.minY
                dayRowFrames.append(dayFrame)
            } else {
                let lastIndex = dayRowFrames.count - 1
                dayRowFrames[lastIndex] = dayRowFrames[lastIndex].union(dayFrame)
            }
        }
        
        // Draw rounded rectangles for each day row
        for dayRowFrame in dayRowFrames {
            let cornerRadius = dayRowFrame.height / 2
            let roundedRectanglePath = UIBezierPath(roundedRect: dayRowFrame, cornerRadius: cornerRadius)
            context?.addPath(roundedRectanglePath.cgPath)
            context?.fillPath()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setNeedsDisplay()
    }
    
    // MARK: Fileprivate
    
    fileprivate var framesOfDaysToHighlight = [CGRect]() {
        didSet {
            guard framesOfDaysToHighlight != oldValue else { return }
            setNeedsDisplay()
        }
    }
    
    // MARK: Private
    
    private let indicatorColor: UIColor
    
}


enum DayRangeSelectionHelper {
    
    static func updateDayRange(
        afterTapSelectionOf day: DayComponents,
        existingDayRange: inout DayComponentsRange?)
    {
        if
            let _existingDayRange = existingDayRange,
            _existingDayRange.lowerBound == _existingDayRange.upperBound,
            day > _existingDayRange.lowerBound
        {
            existingDayRange = _existingDayRange.lowerBound...day
        } else {
            existingDayRange = day...day
        }
    }
    
    static func updateDayRange(
        afterDragSelectionOf day: DayComponents,
        existingDayRange: inout DayComponentsRange?,
        initialDayRange: inout DayComponentsRange?,
        state: UIGestureRecognizer.State,
        calendar: Calendar)
    {
        switch state {
        case .began:
            if day != existingDayRange?.lowerBound, day != existingDayRange?.upperBound {
                existingDayRange = day...day
            }
            initialDayRange = existingDayRange
            
        case .changed, .ended:
            guard let initialDayRange else {
                fatalError("`initialDayRange` should not be `nil`")
            }
            
            let startingLowerDate = calendar.date(from: initialDayRange.lowerBound.components)!
            let startingUpperDate = calendar.date(from: initialDayRange.upperBound.components)!
            let selectedDate = calendar.date(from: day.components)!
            
            let numberOfDaysToLowerDate = calendar.dateComponents(
                [.day],
                from: selectedDate,
                to: startingLowerDate).day!
            let numberOfDaysToUpperDate = calendar.dateComponents(
                [.day],
                from: selectedDate,
                to: startingUpperDate).day!
            
            if
                abs(numberOfDaysToLowerDate) < abs(numberOfDaysToUpperDate) ||
                    day < initialDayRange.lowerBound
            {
                existingDayRange = day...initialDayRange.upperBound
            } else if
                abs(numberOfDaysToLowerDate) > abs(numberOfDaysToUpperDate) ||
                    day > initialDayRange.upperBound
            {
                existingDayRange = initialDayRange.lowerBound...day
            }
            
        default:
            existingDayRange = nil
            initialDayRange = nil
        }
    }
    
}

// MARK: CalendarItemViewRepresentable

extension DayRangeIndicatorView: CalendarItemViewRepresentable {

  struct InvariantViewProperties: Hashable {
    var indicatorColor = UIColor(.accentColor.opacity(0.3))
  }

  struct Content: Equatable {
    let framesOfDaysToHighlight: [CGRect]
  }

  static func makeView(
    withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
    -> DayRangeIndicatorView
  {
    DayRangeIndicatorView(indicatorColor: invariantViewProperties.indicatorColor)
  }

  static func setContent(_ content: Content, on view: DayRangeIndicatorView) {
    view.framesOfDaysToHighlight = content.framesOfDaysToHighlight
  }

}
