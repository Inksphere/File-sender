package com.droplink.offline

import android.content.Context
import android.net.wifi.p2p.WifiP2pManager
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    private lateinit var manager: WifiP2pManager
    private lateinit var channel: WifiP2pManager.Channel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Initialize Android Wi-Fi Direct Engine for zero-internet transfers
        manager = getSystemService(Context.WIFI_P2P_SERVICE) as WifiP2pManager
        channel = manager.initialize(this, mainLooper, null)
        
        startWifiDirectDiscovery()
    }

    private fun startWifiDirectDiscovery() {
        manager.discoverPeers(channel, object : WifiP2pManager.ActionListener {
            override fun onSuccess() {
                println("DropLink Offline: Wi-Fi Direct Peer Discovery Started")
            }
            override fun onFailure(reasonCode: Int) {
                println("DropLink Offline: Discovery Failed $reasonCode")
            }
        })
    }
}
