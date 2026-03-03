--[[
    ██╗     ██╗  ██╗██████╗       █████╗ ██████╗ ███╗   ███╗██╗███╗   ██╗
    ██║     ╚██╗██╔╝██╔══██╗     ██╔══██╗██╔══██╗████╗ ████║██║████╗  ██║
    ██║      ╚███╔╝ ██████╔╝     ███████║██║  ██║██╔████╔██║██║██╔██╗ ██║
    ██║      ██╔██╗ ██╔══██╗     ██╔══██║██║  ██║██║╚██╔╝██║██║██║╚██╗██║
    ███████╗██╔╝ ██╗██║  ██║     ██║  ██║██████╔╝██║ ╚═╝ ██║██║██║ ╚████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝     ╚═╝  ╚═╝╚═════╝ ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝

                    ███╗   ███╗███████╗███╗   ██╗██╗   ██╗
                    ████╗ ████║██╔════╝████╗  ██║██║   ██║
                    ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
                    ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
                    ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
                    ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝

    🐺 LXR Admin Menu — Staff & Server Management Panel

    ═══════════════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════

    Server:    The Land of Wolves 🐺
    Developer: iBoss21 / The Lux Empire
    Website:   https://www.wolves.land
    Discord:   https://discord.gg/CrKcWdfd3A
    GitHub:    https://github.com/iBoss21
    Store:     https://theluxempire.tebex.io

    ═══════════════════════════════════════════════════════════════════════════════

    Framework Support:
    - LXR Core (Primary)
    - RSG Core (Compatible)
    - VORP Core (Compatible)

    ═══════════════════════════════════════════════════════════════════════════════

    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

fx_version 'cerulean'

game 'rdr3'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

name        'lxr-adminmenu'
description 'LXR Admin Menu — Staff & Server Management Panel | wolves.land'
author      'iBoss21 / The Lux Empire (wolves.land)'
version     '1.0.1'

ui_page 'html/index.html'

shared_scripts {
  '@lxr-core/shared/locale.lua',
  'locales/en.lua',
  'shared/config.lua'
}

client_scripts {
  '@menuv/menuv.lua',
  'client/main.lua',
  'client/noclip.lua'
}

files {
  'html/index.html',
  'html/index.js'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/main.lua'
}

lua54 'yes'