import SwiftUI

public struct MoodyView: View {
    public static let info = "Let's track your mood!"

    var id = "asdf"

    public init() { }

    public var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top) {
                Image(systemName: "sun.max")
                    .imageScale(.large)
                    .foregroundColor(.yellow)
                Image(systemName: "cloud.sun")
                    .imageScale(.large)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.blue, .yellow)
                Image(systemName: "cloud")
                    .imageScale(.large)
                    .foregroundColor(.blue)
                Image(systemName: "cloud.rain")
                    .imageScale(.large)
                    .foregroundColor(.blue)
                Image(systemName: "cloud.bolt")
                    .imageScale(.large)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.blue, .yellow)
            }
            Text(MoodyView.info)
        }
        .padding()
    }
}

struct MoodyView_Previews: PreviewProvider {

    static var previews: some View {
        MoodyView()
    }
}
