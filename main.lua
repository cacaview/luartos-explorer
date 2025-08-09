
-- Main application entry point for the 'explorer' app.
-- This file orchestrates the UI setup and event handling.

-- Load core modules
local gui_guider = require("APP.explorer.gui_guider")
local widgets_init = require("APP.explorer.widgets_init")
local events_init = require("APP.explorer.events_init")
local custom = require("APP.explorer.custom")

-- Create the main UI object that will hold all screens and widgets
local guider_ui = {}

-- Initialize the UI
-- This function, defined in gui_guider.lua, sets up the initial screen,
-- keyboard, and loads the 'file' screen.
gui_guider.setup_ui(guider_ui)

-- Initialize custom logic
-- This calls the custom_init function from custom.lua, allowing for
-- user-specific code to be executed after the main UI is set up.
custom.custom_init(guider_ui)

print("Explorer app initialized successfully.")

-- The main loop and event handling are managed by the LuaRTOS core system.
-- This script only needs to perform the initial setup.

return guider_ui

