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

    This configuration file controls the LXR Admin Menu for RedM.
    Admins can manage players, server settings, weather, time, and more.

    ═══════════════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════

    Server:      The Land of Wolves 🐺
    Tagline:     Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
    Description: ისტორია ცოცხლდება აქ! (History Lives Here!)
    Type:        Serious Hardcore Roleplay
    Access:      Discord & Whitelisted

    Developer:   iBoss21 / The Lux Empire
    Website:     https://www.wolves.land
    Discord:     https://discord.gg/CrKcWdfd3A
    GitHub:      https://github.com/iBoss21
    Store:       https://theluxempire.tebex.io
    Server:      https://servers.redm.net/servers/detail/8gj7eb

    ═══════════════════════════════════════════════════════════════════════════════

    Version: 1.0.1
    Performance Target: Optimized for minimal server overhead and client FPS impact

    Framework Support:
    - LXR Core (Primary)
    - RSG Core (Compatible)
    - VORP Core (Compatible)

    ═══════════════════════════════════════════════════════════════════════════════
    CREDITS
    ═══════════════════════════════════════════════════════════════════════════════

    Script Author: iBoss21 / The Lux Empire for The Land of Wolves

    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 RESOURCE NAME PROTECTION - RUNTIME CHECK
-- ═══════════════════════════════════════════════════════════════════════════════

local REQUIRED_RESOURCE_NAME = "lxr-adminmenu"
local currentResourceName = GetCurrentResourceName()

if currentResourceName ~= REQUIRED_RESOURCE_NAME then
    error(string.format([[

        ═══════════════════════════════════════════════════════════════════════════════
        ❌ CRITICAL ERROR: RESOURCE NAME MISMATCH ❌
        ═══════════════════════════════════════════════════════════════════════════════

        Expected: %s
        Got: %s

        This resource is branded and must maintain the correct name.
        Rename the folder to "%s" to continue.

        🐺 wolves.land - The Land of Wolves

        ═══════════════════════════════════════════════════════════════════════════════

    ]], REQUIRED_RESOURCE_NAME, currentResourceName, REQUIRED_RESOURCE_NAME))
end

Config = {}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SERVER BRANDING & INFO ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.ServerInfo = {
    name        = 'The Land of Wolves 🐺',
    tagline     = 'Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!',
    description = 'ისტორია ცოცხლდება აქ!', -- History Lives Here!
    type        = 'Serious Hardcore Roleplay',
    access      = 'Discord & Whitelisted',

    -- Contact & Links
    website       = 'https://www.wolves.land',
    discord       = 'https://discord.gg/CrKcWdfd3A',
    github        = 'https://github.com/iBoss21',
    store         = 'https://theluxempire.tebex.io',
    serverListing = 'https://servers.redm.net/servers/detail/8gj7eb',

    -- Developer Info
    developer = 'iBoss21 / The Lux Empire',
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK CONFIGURATION ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

--[[
    Framework Priority (in order):
    1. LXR-Core  (Primary)
    2. RSG-Core  (Primary)
    3. VORP Core (Supported / Legacy)
]]

Config.Framework = 'lxr-core' -- 'lxr-core' | 'rsg-core' | 'vorp_core'

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ PERMISSION CONFIGURATION ██████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Permissions = {
    ['bring']      = 'admin',
    ['goto']       = 'admin',
    ['freeze']     = 'admin',
    ['spectate']   = 'admin',
    ['ban']        = 'admin',
    ['noclip']     = 'admin',
    ['kickall']    = 'admin',
    ['kick']       = 'admin',
    ['time']       = 'god',
    ['showcoords'] = 'admin',
    ['perms']      = 'god',
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ MENU CONFIGURATION ████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Menu = {
    location = 'topright',   -- Menu position: 'topright' | 'topleft' | 'topcenter'
    size     = 'size-125',   -- Menu size: 'size-100' | 'size-110' | 'size-125' | 'size-150'
    width    = 220,          -- Menu width in pixels
    offsetX  = 20,           -- Horizontal offset
    offsetY  = 60,           -- Vertical offset
}