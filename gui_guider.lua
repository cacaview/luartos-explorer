
--
-- Copyright 2025 NXP
-- NXP Proprietary. This software is owned or controlled by NXP and may only be used strictly in
-- accordance with the applicable license terms. By expressly accepting such terms or by downloading, installing,
-- activating and/or otherwise using the software, you are agreeing that you have read, and that you agree to
-- comply with and are bound by, such license terms.  If you do not agree to be bound by the applicable license
-- terms, then you may not retain, install, activate or otherwise use the software.
--

local gui_guider = {}

function gui_guider.ui_init_style(style)
    if style.prop_cnt > 1 then
        lvgl.style_reset(style)
    else
        lvgl.style_init(style)
    end
end

function gui_guider.ui_load_scr_animation(ui, new_scr_ref, new_scr_del, old_scr_del_ref, setup_scr, anim_type, time, delay, is_clean, auto_del)
    local act_scr = lvgl.scr_act()

    if auto_del and is_clean then
        lvgl.obj_clean(act_scr)
    end
    if new_scr_del then
        setup_scr(ui)
    end
    
    -- In Lua, new_scr_ref is expected to be a table like { value = obj }
    lvgl.scr_load_anim(new_scr_ref.value, anim_type, time, delay, auto_del)
    
    -- old_scr_del_ref is expected to be a table like { value = bool }
    old_scr_del_ref.value = auto_del
end

function gui_guider.ui_animation(var, duration, delay, start_value, end_value, path_cb, repeat_cnt, repeat_delay, playback_time, playback_delay, exec_cb, start_cb, ready_cb, deleted_cb)
    -- As per WIKI.md, lv_anim is not fully bound. This is a placeholder.
    print("Warning: ui_animation is not implemented in Lua bindings.")
end

function gui_guider.init_scr_del_flag(ui)
    ui.file_del = true
    ui.edit_del = true
end

function gui_guider.setup_ui(ui)
    gui_guider.init_scr_del_flag(ui)
    
    -- widgets_init.lua should be required and provides init_keyboard
    local widgets_init = require("widgets_init")
    widgets_init.init_keyboard(ui)
    
    -- setup_scr_file.lua should be required
    local setup_scr_file = require("setup_scr_file")
    setup_scr_file.setup_scr_file(ui)
    
    lvgl.scr_load(ui.file)
end

-- This function will be called from widgets_init.lua
function gui_guider.kb_event_cb(event)
    local code = lvgl.event_get_code(event)
    -- Further implementation from widgets_init.c will be needed here
end

return gui_guider
