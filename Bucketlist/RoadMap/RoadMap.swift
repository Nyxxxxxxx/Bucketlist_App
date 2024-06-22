import SwiftUI

struct CircleView: View {
    let text: String
    let onTap: () -> Void  // Closure to handle tap
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.blue)
                .opacity(0.9)
                .frame(width: 100, height: 100)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 5, y: 5)
                .padding()
                .onTapGesture(perform: onTap)  // Handling tap
                
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

struct RoadMap: View {
    @State private var completedItems = ["Item 1", "Item 2", "Item 3"] // Example items
    @State private var showingItems = false // State to show items
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(1...4, id: \.self) { index in
                    CircleView(text: "202\(index)", onTap: {
                        if index == 4 { // Assuming 2024 corresponds to index 4
                            self.showingItems.toggle() // Toggle visibility of the item list
                        }
                    })
                }
            }
            .padding(.vertical, 60)
        }
        .sheet(isPresented: $showingItems) { // Display a sheet when true
            // This is a simple list, customize it as needed
            List(self.completedItems, id: \.self) { item in
                Text(item)
            }
        }
    }
}

struct RoadMap_Previews: PreviewProvider {
    static var previews: some View {
        RoadMap()
    }
}
