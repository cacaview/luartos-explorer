
--
-- Copyright 2025 NXP
-- NXP Proprietary. This software is owned or controlled by NXP and may only be used strictly in
-- accordance with the applicable license terms. By expressly accepting such terms or by downloading, installing,
-- activating and/or otherwise using the software, you are agreeing that you have read, and that you agree to
-- comply with and are bound by, such license terms.  If you do not agree to be bound by the applicable license
-- terms, then you may not retain, install, activate or otherwise use the software.
--

local widgets_init = {}

function widgets_init.kb_event_cb(e)
    local code = lvgl.event_get_code(e)
    local kb = lvgl.event_get_target(e)
    if code == lvgl.EVENT_READY or code == lvgl.EVENT_CANCEL then
        lvgl.obj_add_flag(kb, lvgl.OBJ_FLAG_HIDDEN)
    end
end

function widgets_init.ta_event_cb(e)
    local code = lvgl.event_get_code(e)
    local ta = lvgl.event_get_target(e)
    local kb = lvgl.event_get_user_data(e)
    
    if code == lvgl.EVENT_FOCUSED or code == lvgl.EVENT_CLICKED then
        -- Per WIKI.md, lv_keyboard_set_textarea is not bound.
        -- lvgl.keyboard_set_textarea(kb, ta)
        print("Warning: lv_keyboard_set_textarea not bound, keyboard cannot be attached to textarea.")
        
        lvgl.obj_move_foreground(kb)
        lvgl.obj_clear_flag(kb, lvgl.OBJ_FLAG_HIDDEN)
    end
    
    if code == lvgl.EVENT_CANCEL or code == lvgl.EVENT_DEFOCUSED then
        -- lvgl.keyboard_set_textarea(kb, nil) -- Detach
        print("Warning: lv_keyboard_set_textarea not bound, keyboard cannot be detached from textarea.")
        
        lvgl.obj_move_background(kb)
        lvgl.obj_add_flag(kb, lvgl.OBJ_FLAG_HIDDEN)
    end
end

function widgets_init.clock_count(time_ref)
    -- time_ref is expected to be a table like { hour=h, min=m, sec=s }
    time_ref.sec = time_ref.sec + 1
    if time_ref.sec == 60 then
        time_ref.sec = 0
        time_ref.min = time_ref.min + 1
    end
    if time_ref.min == 60 then
        time_ref.min = 0
        time_ref.hour = (time_ref.hour % 12) + 1
    end
end

-- This function was in gui_guider.c but is more related to widgets
function widgets_init.init_keyboard(ui)
    ui.g_kb_top_layer = lvgl.keyboard_create(lvgl.scr_act())
    lvgl.obj_add_event_cb(ui.g_kb_top_layer, widgets_init.kb_event_cb, lvgl.EVENT_ALL, nil)
    lvgl.obj_add_flag(ui.g_kb_top_layer, lvgl.OBJ_FLAG_HIDDEN)
    
    -- Assuming lv_font_SourceHanSerifSC_Regular_18 is available as a function
    -- This might need adjustment based on how custom fonts are handled.
    -- lvgl.obj_set_style_text_font(ui.g_kb_top_layer, lvgl.font_sourcehansans_18(), lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
end

return widgets_init
