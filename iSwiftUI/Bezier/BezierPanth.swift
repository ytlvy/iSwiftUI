import SwiftUI
import SpriteKit

let tick = Timer.publish(every: 2, on: .main,
                         in: .common).autoconnect()

struct BezierContentView: View {
    
    @State var redraw = false
    
    @State var orangeImage = "circle"
    @State var greenImage = "circle"
    
    @State var adjustmentX:CGFloat = 8
    @State var adjustmentY:CGFloat = 8
    
    @State var function:Int = 0
    
    @ObservedObject var values = Figures.shared
    
    var body: some View {
        ZStack {
            
            Image(systemName: orangeImage)
                .font(.system(.largeTitle))
                .foregroundColor(Color.orange)
                .frame(width: 32, height: 32, alignment: .center)
                .position(values.controls.feed2)
                .frame(width: 256, height: 256, alignment: .center)
                .onTapGesture {
                    switch orangeImage {
                    case "arrow.up.circle.fill":
                        withAnimation {
                            values.controls.control2.y -= 8
                            redraw.toggle()
                        }
                    case "arrow.down.circle.fill":
                        withAnimation {
                            values.controls.control2.y += 8
                            redraw.toggle()
                        }
                    case "arrow.right.circle.fill":
                        withAnimation {
                            values.controls.control2.x -= 8
                            redraw.toggle()
                        }
                    case "arrow.left.circle.fill":
                        withAnimation {
                            values.controls.control2.x += 8
                            redraw.toggle()
                        }
                    default:
                        break
                    }
                }.onLongPressGesture {
                    print("\(values.controls.control2.x) \(values.controls.control2.y)")
                    switch orangeImage {
                    case "arrow.up.circle.fill":
                        orangeImage = "arrow.down.circle.fill"
                    case "arrow.down.circle.fill":
                        orangeImage = "arrow.left.circle.fill"
                    case "arrow.left.circle.fill":
                        orangeImage = "arrow.right.circle.fill"
                    case "arrow.right.circle.fill":
                        orangeImage = "circle"
                    case "circle":
                        orangeImage = "arrow.up.circle.fill"
                    default:
                        break
                    }
                }
            
            
            Image(systemName: greenImage)
                .font(.system(.largeTitle))
                .foregroundColor(Color.green)
                .frame(width: 32, height: 32, alignment: .center)
                .position(values.controls.feed1)
                .frame(width: 256, height: 256, alignment: .center)
                .onTapGesture {
                    switch greenImage {
                    case "arrow.up.circle.fill":
                        withAnimation {
                            values.controls.control1.y += 8
                            redraw.toggle()
                        }
                    case "arrow.down.circle.fill":
                        withAnimation {
                            values.controls.control1.y -= 8
                            redraw.toggle()
                        }
                    case "arrow.right.circle.fill":
                        withAnimation {
                            values.controls.control1.x += 8
                            redraw.toggle()
                        }
                    case "arrow.left.circle.fill":
                        withAnimation {
                            values.controls.control1.x -= 8
                            redraw.toggle()
                        }
                    default:
                        break
                    }
                }.onLongPressGesture {
                    print("\(values.controls.control1.x) \(values.controls.control1.y)")
                    switch greenImage {
                    case "arrow.up.circle.fill":
                        greenImage = "arrow.down.circle.fill"
                    case "arrow.down.circle.fill":
                        greenImage = "arrow.left.circle.fill"
                    case "arrow.left.circle.fill":
                        greenImage = "arrow.right.circle.fill"
                    case "arrow.right.circle.fill":
                        greenImage = "circle"
                    case "circle":
                        greenImage = "arrow.up.circle.fill"
                    default:
                        break
                    }
                }
            
            ForEach (0...20, id: \.self) { zak in
                newCurve(function: function)
                    .stroke(doColor(shade: Double((zak * 18))), lineWidth: 4)
                    .opacity(0.8)
                    .frame(width: 256, height: 256, alignment: .center)
                    .id(redraw)
                    .background(InnerView())
                    .rotationEffect(.degrees(Double(18 * zak)))
            }
            Color.clear
                .onReceive(tick) { (_) in
                    function = (function + 1) % 16
                }
            //          newArc()
            //            .stroke(Color.gray, lineWidth: 4)
            //            .frame(width: 256, height: 256, alignment: .center)
            
        }
    }
}

struct newArc: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center:CGPoint = CGPoint(x: rect.midX,y: rect.midY)
        
        path.move(to: CGPoint(x: center.x + 64, y: center.y))
        path.addArc(center: center, radius: 64, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
        return path
    }
}

struct Flower: Shape {
    @ObservedObject var values = Figures.shared
    
    func path(in rect: CGRect) -> Path {
        
        values.controls.feed1 = CGPoint(x:rect.midX + values.controls.control1.x,y:rect.midY - values.controls.control1.y)
        values.controls.feed2 = CGPoint(x:rect.midX - values.controls.control2.x,y:rect.midY + values.controls.control2.y)
        values.controls.rectX = rect
        
        var path = Path()
        let center:CGPoint = CGPoint(x: rect.midX,y: rect.midY)
        path.move(to: CGPoint(x: center.x, y: center.y))
        path.addCurve(to: CGPoint(x:rect.midX,y: rect.midY), control1: CGPoint(x:rect.midX - 64,y:rect.midY - 64), control2: CGPoint(x: rect.midX - 64,y:rect.midY + 64))
        path.addCurve(to: CGPoint(x:rect.midX,y: rect.midY), control1: CGPoint(x:rect.midX - 64,y:rect.midY + 64), control2: CGPoint(x: rect.midX + 64,y:rect.midY + 64))
        path.addCurve(to: CGPoint(x:rect.midX,y: rect.midY), control1: CGPoint(x:rect.midX + 64,y:rect.midY - 64), control2: CGPoint(x: rect.midX - 64,y:rect.midY - 64))
        path.addCurve(to: CGPoint(x:rect.midX,y: rect.midY), control1: CGPoint(x:rect.midX + 64,y:rect.midY + 64), control2: CGPoint(x: rect.midX + 64,y:rect.midY - 64))
        print("path ",path.description)
        return path
    }
}

struct newCurve: Shape {
    @ObservedObject var values = Figures.shared
    @State var function: Int
    
    func path(in rect: CGRect) -> Path {
        
        values.controls.feed1 = CGPoint(x:rect.midX + values.controls.control1.x,y:rect.midY - values.controls.control1.y)
        values.controls.feed2 = CGPoint(x:rect.midX - values.controls.control2.x,y:rect.midY + values.controls.control2.y)
        values.controls.rectX = rect
        
        
        var path = Path()
        let center:CGPoint = CGPoint(x: rect.midX,y: rect.midX - 64)
        let backer:CGPoint = CGPoint(x: rect.midX,y: rect.midY + 64)
        
        let com1A:CGPoint = CGPoint(x: rect.midX + values.controls.control1.x, y: rect.midX + values.controls.control1.y)
        let com2A:CGPoint = CGPoint(x: rect.midX + values.controls.control1.x, y: rect.midX - values.controls.control1.y)
        let com3A:CGPoint = CGPoint(x: rect.midX - values.controls.control1.x, y: rect.midX + values.controls.control1.y)
        let com4A:CGPoint = CGPoint(x: rect.midX - values.controls.control1.x, y: rect.midX - values.controls.control1.y)
        
        let com1B:CGPoint = CGPoint(x: rect.midX + values.controls.control2.x, y: rect.midX + values.controls.control2.y)
        let com2B:CGPoint = CGPoint(x: rect.midX + values.controls.control2.x, y: rect.midX - values.controls.control2.y)
        let com3B:CGPoint = CGPoint(x: rect.midX - values.controls.control2.x, y: rect.midX + values.controls.control2.y)
        let com4B:CGPoint = CGPoint(x: rect.midX - values.controls.control2.x, y: rect.midX - values.controls.control2.y)
        
        print("function ",function)
        path.move(to: CGPoint(x: center.x, y: center.y))
        switch function {
        case 0:
            path.addCurve(to: backer, control1: com1A, control2: com1B)
        case 1:
            path.addCurve(to: backer, control1: com1A, control2: com2B)
        case 2:
            path.addCurve(to: backer, control1: com1A, control2: com3B)
        case 3:
            path.addCurve(to: backer, control1: com1A, control2: com4B)
        case 4:
            path.addCurve(to: backer, control1: com2A, control2: com1B)
        case 5:
            path.addCurve(to: backer, control1: com2A, control2: com2B)
        case 6:
            path.addCurve(to: backer, control1: com2A, control2: com3B)
        case 7:
            path.addCurve(to: backer, control1: com2A, control2: com4B)
        case 8:
            path.addCurve(to: backer, control1: com3A, control2: com1B)
        case 9:
            path.addCurve(to: backer, control1: com3A, control2: com2B)
        case 10:
            path.addCurve(to: backer, control1: com3A, control2: com3B)
        case 11:
            path.addCurve(to: backer, control1: com3A, control2: com4B)
        case 12:
            path.addCurve(to: backer, control1: com4A, control2: com1B)
        case 13:
            path.addCurve(to: backer, control1: com4A, control2: com2B)
        case 14:
            path.addCurve(to: backer, control1: com4A, control2: com3B)
        case 15:
            path.addCurve(to: backer, control1: com4A, control2: com4B)
            
        default:
            break
        }
        
        
        return path
    }
}

func doColor(shade: Double) -> Color {
    let hue2U = Double(shade / 360)
    let color = Color.init(hue: hue2U, saturation: 0.66, brightness: 0.66, opacity: 1.0)
    return color
}

struct InnerView: View {
    var body: some View {
        GeometryReader { geo in
            Color.clear
                .onAppear {
                    print("geo \(geo.frame(in: .global).minX) \(geo.frame(in: .global).minY)")
                }
        }
    }
}

struct BezierContentView_Previews: PreviewProvider {
    static var previews: some View {
        BezierContentView()
    }
}
