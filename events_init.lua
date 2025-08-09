
--
-- Copyright 2025 NXP
-- NXP Proprietary. This software is owned or controlled by NXP and may only be used strictly in
-- accordance with the applicable license terms. By expressly accepting such terms or by downloading, installing,
-- activating and/or otherwise using the software, you are agreeing that you have read, and that you agree to
-- comply with and are bound by, such license terms.  If you do not agree to be bound by the applicable license
-- terms, then you may not retain, install, activate or otherwise use the software.
--

local events_init = {}

local gui_guider = require("gui_guider")
local setup_scr_edit = require("setup_scr_edit")
local setup_scr_file = require("setup_scr_file")

-- Event handler for file_file_list_item0
local function file_file_list_item0_event_handler(e)
    local code = lvgl.event_get_code(e)
    local ui = lvgl.event_get_user_data(e)
    
    if code == lvgl.EVENT_LONG_PRESSED() then
        lvgl.obj_clear_flag(ui.file_operate, lvgl.OBJ_FLAG_HIDDEN())
    end
end

-- Event handler for file_operate_item4
local function file_operate_item4_event_handler(e)
    local code = lvgl.event_get_code(e)
    local ui = lvgl.event_get_user_data(e)

    if code == lvgl.EVENT_CLICKED() then
        -- ui_load_scr_animation needs references passed as tables
        local new_scr_ref = { value = ui.edit }
        local old_scr_del_ref = { value = ui.file_del }
        gui_guider.ui_load_scr_animation(ui, new_scr_ref, ui.edit_del, old_scr_del_ref, setup_scr_edit.setup_scr_edit, lvgl.SCR_LOAD_ANIM_NONE(), 200, 200, true, true)
        ui.file_del = old_scr_del_ref.value
    end
end

-- Event handler for file_operate_item5
local function file_operate_item5_event_handler(e)
    local code = lvgl.event_get_code(e)
    local ui = lvgl.event_get_user_data(e)
    
    if code == lvgl.EVENT_CLICKED() then
        lvgl.obj_add_flag(ui.file_operate, lvgl.OBJ_FLAG_HIDDEN())
    end
end

-- Event handler for file_btn_back
local function file_btn_back_event_handler(e)
    local code = lvgl.event_get_code(e)
    if code == lvgl.EVENT_CLICKED() then
        -- No action defined
    end
end

function events_init.events_init_file(ui)
    lvgl.obj_add_event_cb(ui.file_file_list_item0, file_file_list_item0_event_handler, lvgl.EVENT_ALL(), ui)
    lvgl.obj_add_event_cb(ui.file_operate_item4, file_operate_item4_event_handler, lvgl.EVENT_ALL(), ui)
    lvgl.obj_add_event_cb(ui.file_operate_item5, file_operate_item5_event_handler, lvgl.EVENT_ALL(), ui)
    lvgl.obj_add_event_cb(ui.file_btn_back, file_btn_back_event_handler, lvgl.EVENT_ALL(), ui)
end

-- Event handler for edit_btn_back
local function edit_btn_back_event_handler(e)
    local code = lvgl.event_get_code(e)
    local ui = lvgl.event_get_user_data(e)
    
    if code == lvgl.EVENT_CLICKED() then
        local new_scr_ref = { value = ui.file }
        local old_scr_del_ref = { value = ui.edit_del }
        gui_guider.ui_load_scr_animation(ui, new_scr_ref, ui.file_del, old_scr_del_ref, setup_scr_file.setup_scr_file, lvgl.SCR_LOAD_ANIM_NONE(), 200, 200, true, true)
        ui.edit_del = old_scr_del_ref.value
    end
end

function events_init.events_init_edit(ui)
    lvgl.obj_add_event_cb(ui.edit_btn_back, edit_btn_back_event_handler, lvgl.EVENT_ALL(), ui)
end

function events_init.events_init(ui)
    -- This function is empty in the C source
end

return events_init
