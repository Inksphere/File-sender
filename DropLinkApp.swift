import SwiftUI
import Network

@main
struct DropLinkApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @StateObject private var p2pListener = OfflineP2PListener()

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi")
                .font(.system(size: 50))
                .foregroundColor(.yellow)
            Text("DropLink iOS Offline Native Engine")
                .font(.headline)
            Text(p2pListener.status)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .onAppear {
            p2pListener.startBonjourListener()
        }
    }
}

class OfflineP2PListener: ObservableObject {
    @Published var status = "Searching for nearby DropLink devices..."
    private var listener: NWListener?

    func startBonjourListener() {
        do {
            let tcpOptions = NWProtocolTCP.Options()
            let params = NWParameters(tls: nil, tcp: tcpOptions)
            listener = try NWListener(using: params)
            listener?.service = NWListener.Service(name: "DropLink-iOS", type: "_droplink._tcp")
            listener?.start(queue: .main)
            status = "Listening on local Wi-Fi / Hotspot"
        } catch {
            status = "Listener Error: \(error.localizedDescription)"
        }
    }
}
