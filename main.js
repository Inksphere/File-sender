const { app, BrowserWindow, ipcMain } = require('electron');
const path = require('path');
const dgram = require('dgram');

let mainWindow;

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 900,
    height: 700,
    backgroundColor: '#08090e',
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false
    }
  });

  mainWindow.loadFile('index.html');
}

// Local UDP Discovery for Desktop (Windows, macOS, Ubuntu)
const udpSocket = dgram.createSocket('udp4');

udpSocket.on('listening', () => {
  udpSocket.setBroadcast(true);
  console.log('DropLink Desktop Local Transport Ready');
});

udpSocket.bind(41234);

app.whenReady().then(createWindow);

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});
