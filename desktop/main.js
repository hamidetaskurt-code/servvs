const { app, BrowserWindow, Menu } = require('electron');
const path = require('path');

let mainWindow;

function createWindow() {
    mainWindow = new BrowserWindow({
        width: 1400,
        height: 900,
        minWidth: 1200,
        minHeight: 700,
        webPreferences: {
            nodeIntegration: true,
            contextIsolation: false,
            enableRemoteModule: false,
            webSecurity: false  // Allow loading images from backend
        },
        icon: path.join(__dirname, 'icon.png'),
        backgroundColor: '#0f172a',
        show: false
    });

    mainWindow.loadFile('src/pages/index.html');

    // Open DevTools automatically in development
    mainWindow.webContents.openDevTools();

    mainWindow.once('ready-to-show', () => {
        mainWindow.show();
    });

    // Menu
    const template = [
        {
            label: 'Dosya',
            submenu: [
                {
                    label: 'Yeniden Yükle',
                    accelerator: 'CmdOrCtrl+R',
                    click: () => mainWindow.reload()
                },
                { type: 'separator' },
                {
                    label: 'Çıkış',
                    accelerator: 'CmdOrCtrl+Q',
                    click: () => app.quit()
                }
            ]
        },
        {
            label: 'Görünüm',
            submenu: [
                {
                    label: 'Tam Ekran',
                    accelerator: 'F11',
                    click: () => {
                        mainWindow.setFullScreen(!mainWindow.isFullScreen());
                    }
                },
                { type: 'separator' },
                {
                    label: 'Geliştirici Araçları',
                    accelerator: 'F12',
                    click: () => mainWindow.webContents.toggleDevTools()
                }
            ]
        },
        {
            label: 'Yardım',
            submenu: [
                {
                    label: 'Hakkında',
                    click: () => {
                        const { dialog } = require('electron');
                        dialog.showMessageBox(mainWindow, {
                            type: 'info',
                            title: 'Akın Kombi',
                            message: 'Akın Kombi Servis Yönetim Sistemi',
                            detail: 'Versiyon: 1.0.0\n© 2025 Akın Kombi'
                        });
                    }
                }
            ]
        }
    ];

    const menu = Menu.buildFromTemplate(template);
    Menu.setApplicationMenu(menu);

    mainWindow.on('closed', () => {
        mainWindow = null;
    });
}

app.whenReady().then(createWindow);

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
        app.quit();
    }
});

app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
        createWindow();
    }
});
