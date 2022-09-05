//
//  TimerView.swift
//  Rebuke
//
//  Created by Joseph William DeWeese on 8/25/22.
//

import SwiftUI


struct SizeKey: PreferenceKey {
    static let defaultValue: [CGSize] = []
    static func reduce(value: inout [CGSize], nextValue: () -> [CGSize]) {
        value.append(contentsOf: nextValue())
    }
}
struct ButtonCircle: ViewModifier {
    let isPressed: Bool
    
    func body(content: Content) -> some View {
        let background = Circle()
            .fill()
            .overlay(
                Circle()
                    .fill(Color.white)
                    .opacity(isPressed ? 0.3 : 0)
            )
            .overlay(
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.white)
                    .padding(4)
            )
        let foreground = content
            .fixedSize()
            .padding(15)
            .equalSize()
            .foregroundColor(.white)
        return foreground
            .background(background)
    }
}
struct SizeEnvironmentKey: EnvironmentKey {
    static let defaultValue: CGSize? = nil
}
extension EnvironmentValues {
    var size: CGSize? {
        get { self[SizeEnvironmentKey.self] }
        set { self[SizeEnvironmentKey.self] = newValue }
    }
}
fileprivate struct EqualSize: ViewModifier {
    @Environment(\.size) private var size
    
    func body(content: Content) -> some View {
        content.overlay(GeometryReader { proxy in
            Color.clear.preference(key: SizeKey.self, value: [proxy.size])
        })
        .frame(width: size?.width, height: size?.width)
    }
}
fileprivate struct EqualSizes: ViewModifier {
    @State var width: CGFloat?
    func body(content: Content) -> some View {
        content.onPreferenceChange(SizeKey.self, perform: { sizes in
            self.width = sizes.map { $0.width }.max()
        }).environment(\.size, width.map { CGSize(width: $0, height: $0) })
    }
}

extension View {
    func equalSize() -> some View {
        self.modifier(EqualSize())
    }
    
    func equalSizes() -> some View {
        self.modifier(EqualSizes())
    }
}

struct CircleStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        configuration.label.modifier(ButtonCircle(isPressed: configuration.isPressed))
    }
}

let formatter: DateComponentsFormatter = {
    let f = DateComponentsFormatter()
    f.allowedUnits = [.minute, .second]
    f.zeroFormattingBehavior = .pad
    return f
}()
let numberFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.minimumFractionDigits = 2
    f.maximumFractionDigits = 2
    f.maximumIntegerDigits  = 0
    f.alwaysShowsDecimalSeparator = true
    return f
}()

extension TimeInterval {
    var formatted: String {
        let ms = self.truncatingRemainder(dividingBy: 1)
        return formatter.string(from: self)! + numberFormatter.string(from: NSNumber(value: ms))!
    }
}

extension View {
    func visible(_ v: Bool) -> some View {
        self.opacity(v ? 1 : 0)
    }
}

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    init(center: CGPoint, radius: CGFloat) {
        self = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
    }
}

struct Pointer: Shape {
    var circleRadius: CGFloat = 3
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: rect.midX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY - circleRadius))
            p.addEllipse(in: CGRect(center: rect.center, radius: circleRadius))
            p.move(to: CGPoint(x: rect.midX, y: rect.midY + circleRadius))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY + rect.height / 5))
        }
    }
}
extension CGPoint {
    init(angle: Angle, distance: CGFloat) {
        self = CGPoint(x:  CGFloat(cos(angle.radians)) * distance, y: CGFloat(sin(angle.radians)) * distance)
    }
    var size: CGSize {
        CGSize(width: x, height: y)
    }
}
struct Labels: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack{
                ForEach(0..<12) { idx in
                    Text("\(idx ==  0  ? 60 :  idx  * 5)")
                        .offset(CGPoint(angle: Angle.degrees(360 * Double(idx)/12-92),
                                        distance:  proxy.size.width).size)
                }
            }
        }
    }
}
struct Ticks: View {
    func tick(at tick: Int) -> some View {
        VStack {
            Rectangle()
                .fill(Color.primary)
                .opacity(tick % 20 == 0 ? 1 : 0.4)
                .frame(width: 2, height: tick % 4 == 0 ? 15 : 7)
            Spacer()
        }.rotationEffect(Angle.degrees(Double(tick)/240 * 360))
    }
    var body: some View {
        ForEach(0..<60*4) { tick in
            self.tick(at: tick)
        }
    }
}

struct Clock: View {
    //JWD: Properties...
    var time: TimeInterval = 10
    var lapTime: TimeInterval?
    
    //TODO:  Add a placemat under the clock - mucgh like the clock widget on homescreen
    var body: some View {
        ZStack {
            Ticks()
            Labels()
                .offset(x:50, y: 50)
                .padding(90)
                .font(.subheadline)
            Text(time.formatted)
                .foregroundColor(.accentColor)
                .font(Font.system(size: 30,  weight:   .regular).monospacedDigit())
                .offset(y: 70)
            
            if lapTime != nil {
                Pointer()
                    .stroke(Color.green, lineWidth: 2)
                    .rotationEffect(Angle.degrees(Double(lapTime!) * 360/60))
            }
            Pointer()
                .stroke(Color.red, lineWidth: 2)
                .rotationEffect(Angle.degrees(Double(time) * 360/60))
            Color.clear
        }.aspectRatio(1, contentMode: .fit)
        
    }
}


struct  TimerView: View {
    @ObservedObject var stopwatch = Stopwatch()
   
    
    var body: some View {
        VStack {
            Clock(time: stopwatch.total, lapTime: stopwatch.laps.last?.0).frame(width: 300, height: 300, alignment: .center)
        }
        //            Text(stopwatch.total.formatted)
        //                .font(Font.system(size: 64, weight: .thin).monospacedDigit())
        HStack {
            ZStack {
                Spacer()
                //JWD:  STOP / START BUTTON
                Button(action: { self.stopwatch.stop() }) {
                    Text("Stop")
                }
                .foregroundColor(.red)
                .visible(stopwatch.isRunning)
                Button(action: { self.stopwatch.start() }) {
                    Text("Start")
                }
                .foregroundColor(.green)
                .visible(!stopwatch.isRunning)
            }
            Spacer()
            ZStack {
                //JWD:  NEXT / RESET BUTTON
                Button(action: { self.stopwatch.lap() }) {
                    Text("Next")
                }
                .foregroundColor(.gray)
                .visible(stopwatch.isRunning)
                Button(action: { self.stopwatch.reset() }) {
                    Text("Reset")
                }
                .foregroundColor(.gray)
                .visible(!stopwatch.isRunning)
            }
            Spacer()
            ZStack {
                
                //JWD:  FINISH BUTTON
                Button(action: { self.stopwatch.stop() }) {
                    Text("Finish")
                }
                .foregroundColor(.init( UIColor.systemBlue))
                Spacer()
            }
        }
        .padding(.horizontal)
        .equalSizes()
        .padding()
        .buttonStyle(CircleStyle())
        Spacer()
        List {
            ForEach(stopwatch.laps.enumerated().reversed(), id: \.offset) { value in
                HStack {
                    
                    Text("\(value.offset + 1)  ")
                    Text("Current Exercise Name")
                    Spacer()
                    Text(value.element.0.formatted)
                        .font(Font.body.monospacedDigit())
                }.foregroundColor(value.element.1.color)
                    .background()
            }
        }
    }
    
}


extension LapType {
    var color: Color {
        switch self {
        case .regular:
            return .primary
        case .shortest:
            return .green
        case .longest:
            return .red
        }
    }
}

final class Stopwatch: ObservableObject {
    @Published private var data = StopwatchData()
    private var timer: Timer?
    
    var total: TimeInterval {
        data.totalTime
    }
    
    var isRunning: Bool {
        data.absoluteStartTime != nil
    }
    
    var laps: [(TimeInterval, LapType)] { data.laps }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] timer in
            self.data.currentTime = Date().timeIntervalSinceReferenceDate
        })
        data.start(at: Date().timeIntervalSinceReferenceDate)
    }
    //TODO: Add "Finish" button function
    func stop() {
        timer?.invalidate()
        timer = nil
        data.stop()
    }
    
    func reset() {
        stop()
        data = StopwatchData()
    }
    
    func lap() {
        data.lap()
    }
    
    deinit {
        stop()
    }
}

enum LapType {
    case regular
    case shortest
    case longest
}
//JWD:  *STOPWATCH VARIABLES*
struct StopwatchData {
    var absoluteStartTime: TimeInterval?
    var currentTime: TimeInterval = 0
    var additionalTime: TimeInterval = 0
    var lastLapEnd: TimeInterval = 0
    var _laps: [(TimeInterval, LapType)] = []
    
    var laps: [(TimeInterval, LapType)] {
        guard totalTime > 0 else { return [] }
        return _laps + [(currentLapTime, .regular)]
    }
    
    var currentLapTime: TimeInterval {
        totalTime - lastLapEnd
    }
    
    var totalTime: TimeInterval {
        guard let start = absoluteStartTime else { return additionalTime }
        return additionalTime + currentTime - start
    }
    
    mutating func start(at time: TimeInterval) {
        currentTime = time
        absoluteStartTime = time
    }
    
    mutating func stop() {
        additionalTime = totalTime
        absoluteStartTime = nil
    }
    
    mutating func lap() {
        let lapTimes = _laps.map { $0.0 } + [currentLapTime]
        if let shortest = lapTimes.min(), let longest = lapTimes.max(), shortest != longest {
            _laps = lapTimes.map { ($0, $0 == shortest ? .shortest : ($0 == longest ? .longest : .regular ))}
        } else {
            _laps = lapTimes.map { ($0, .regular) }
        }
        lastLapEnd = totalTime
    }
}
