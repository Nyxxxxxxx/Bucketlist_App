//import SwiftUI
//
//enum PopupStyle {
//    case none
//    case blur
//    case dimmed
//}
//
//fileprivate struct Popup<Message: View>: ViewModifier {
//    let size: CGSize?
//    let style: PopupStyle
//    let message: Message
//    @Binding var isPresented: Bool
//    
//    init(
//        size: CGSize? = nil,
//        style: PopupStyle = .none,
//        isPresented: Binding<Bool>,
//        message: Message
//    ) {
//        self.size = size
//        self.style = style
//        self._isPresented = isPresented
//        self.message = message
//    }
//    
//    func body(content: Content) -> some View {
//        ZStack {
//            content
//                .blur(radius: style == .blur ? 2 : 0)
//                .disabled(isPresented)
//            
//            if isPresented {
//                Color.black.opacity(style == .dimmed ? 0.4 : 0)
//                    .edgesIgnoringSafeArea(.all)
//                    .onTapGesture {
//                        isPresented = false
//                    }
//                
//                popupContent
//                    .onTapGesture {
//                        // 팝업 내부를 클릭해도 닫히지 않도록
//                    }
//            }
//        }
//    }
//    
//    private var popupContent: some View {
//        GeometryReader { geometry in
//            VStack {
//                self.message
//            }
//            .frame(width: self.size?.width ?? geometry.size.width * 0.7,
//                   height: self.size?.height ?? geometry.size.height * 0.25)
//            .background(Color.primary.colorInvert())
//            .cornerRadius(12)
//            .shadow(color: .primaryShadow, radius: 15, x: 5, y: 5)
//            .position(x: geometry.size.width / 2, y: geometry.size.height / 2.5)
//        }
//    }
//}
//
//extension View {
//    func popup<Content: View>(
//        isPresented: Binding<Bool>,
//        size: CGSize? = nil,
//        style: PopupStyle = .none,
//        @ViewBuilder content: () -> Content
//    ) -> some View {
//        self.modifier(Popup(size: size, style: style, isPresented: isPresented, message: content()))
//    }
//}
