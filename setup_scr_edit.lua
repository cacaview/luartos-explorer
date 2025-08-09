
--
-- Copyright 2025 NXP
-- NXP Proprietary. This software is owned or controlled by NXP and may only be used strictly in
-- accordance with the applicable license terms. By expressly accepting such terms or by downloading, installing,
-- activating and/or otherwise using the software, you are agreeing that you have read, and that you agree to
-- comply with and are bound by, such license terms.  If you do not agree to be bound by the applicable license
-- terms, then you may not retain, install, activate or otherwise use the software.
--

local setup_scr_edit = {}

-- Forward declaration of dependencies
local events_init = require("events_init")
local widgets_init = require("widgets_init")
-- local custom = require("custom") -- Assuming custom.lua will exist

function setup_scr_edit.setup_scr_edit(ui)
    -- Create screen: edit
    ui.edit = lvgl.obj_create(nil)
    lvgl.obj_set_size(ui.edit, 480, 320)
    lvgl.obj_set_scrollbar_mode(ui.edit, lvgl.SCROLLBAR_MODE_OFF())
    lvgl.obj_set_style_bg_opa(ui.edit, 0, lvgl.PART_MAIN())

    -- Create container: edit_cont_1
    ui.edit_cont_1 = lvgl.obj_create(ui.edit)
    lvgl.obj_set_pos(ui.edit_cont_1, 0, 0)
    lvgl.obj_set_size(ui.edit_cont_1, 480, 320)
    lvgl.obj_set_scrollbar_mode(ui.edit_cont_1, lvgl.SCROLLBAR_MODE_OFF())
    lvgl.obj_set_style_border_width(ui.edit_cont_1, 2, lvgl.PART_MAIN())
    lvgl.obj_set_style_border_color(ui.edit_cont_1, lvgl.color_hex(0x2195f6), lvgl.PART_MAIN())
    lvgl.obj_set_style_radius(ui.edit_cont_1, 0, lvgl.PART_MAIN())
    lvgl.obj_set_style_pad_all(ui.edit_cont_1, 0, lvgl.PART_MAIN())

    -- Create spangroup: edit_spangroup_1
    ui.edit_spangroup_1 = lvgl.spangroup_create(ui.edit_cont_1)
    lvgl.spangroup_set_align(ui.edit_spangroup_1, lvgl.TEXT_ALIGN_LEFT())
    lvgl.spangroup_set_overflow(ui.edit_spangroup_1, lvgl.SPAN_OVERFLOW_CLIP())
    lvgl.spangroup_set_mode(ui.edit_spangroup_1, lvgl.SPAN_MODE_BREAK())
    
    local span = lvgl.spangroup_new_span(ui.edit_spangroup_1)
    lvgl.span_set_text(span, "edit")
    -- In Lua, styles on spans are handled differently. We need to set style properties on the span object itself.
    -- This is a simplified approach. A more robust solution might involve creating and applying a style object.
    -- lvgl.span_set_style_text_color(span, lvgl.color_hex(0x000000))
    -- lvgl.span_set_style_text_font(span, lvgl.font_montserrat_20())
    
    lvgl.obj_set_pos(ui.edit_spangroup_1, 126, 22)
    lvgl.obj_set_size(ui.edit_spangroup_1, 196, 30)
    lvgl.spangroup_refr_mode(ui.edit_spangroup_1)

    -- Create textarea: edit_ta_1
    ui.edit_ta_1 = lvgl.textarea_create(ui.edit_cont_1)
    lvgl.textarea_set_text(ui.edit_ta_1, "here is your text.")
    lvgl.textarea_set_one_line(ui.edit_ta_1, true)
    lvgl.obj_add_event_cb(ui.edit_ta_1, widgets_init.ta_event_cb, lvgl.EVENT_ALL(), ui.g_kb_top_layer)
    lvgl.obj_set_pos(ui.edit_ta_1, 54, 85)
    lvgl.obj_set_size(ui.edit_ta_1, 361, 196)

    lvgl.obj_set_style_text_font(ui.edit_ta_1, lvgl.font_montserrat_12(), lvgl.PART_MAIN())
    lvgl.obj_set_style_border_color(ui.edit_ta_1, lvgl.color_hex(0xe6e6e6), lvgl.PART_MAIN())
    lvgl.obj_set_style_border_width(ui.edit_ta_1, 2, lvgl.PART_MAIN())
    lvgl.obj_set_style_radius(ui.edit_ta_1, 4, lvgl.PART_MAIN())
    lvgl.obj_set_style_pad_all(ui.edit_ta_1, 4, lvgl.PART_MAIN())
    
    -- Create button: edit_btn_save
    ui.edit_btn_save = lvgl.btn_create(ui.edit_cont_1)
    lvgl.obj_set_pos(ui.edit_btn_save, 389, 20)
    lvgl.obj_set_size(ui.edit_btn_save, 65, 40)
    
    ui.edit_btn_save_label = lvgl.label_create(ui.edit_btn_save)
    lvgl.label_set_text(ui.edit_btn_save_label, "save")
    lvgl.obj_center(ui.edit_btn_save_label)
    
    lvgl.obj_set_style_bg_color(ui.edit_btn_save, lvgl.color_hex(0x2195f6), lvgl.PART_MAIN())
    lvgl.obj_set_style_radius(ui.edit_btn_save, 5, lvgl.PART_MAIN())
    lvgl.obj_set_style_text_color(ui.edit_btn_save_label, lvgl.color_white(), lvgl.PART_MAIN())
    lvgl.obj_set_style_text_font(ui.edit_btn_save_label, lvgl.font_montserrat_16(), lvgl.PART_MAIN())

    -- Create button: edit_btn_back
    ui.edit_btn_back = lvgl.btn_create(ui.edit_cont_1)
    lvgl.obj_set_pos(ui.edit_btn_back, 17, 20)
    lvgl.obj_set_size(ui.edit_btn_back, 65, 40)

    ui.edit_btn_back_label = lvgl.label_create(ui.edit_btn_back)
    lvgl.label_set_text(ui.edit_btn_back_label, "back")
    lvgl.obj_center(ui.edit_btn_back_label)

    lvgl.obj_set_style_bg_color(ui.edit_btn_back, lvgl.color_hex(0x2195f6), lvgl.PART_MAIN())
    lvgl.obj_set_style_radius(ui.edit_btn_back, 5, lvgl.PART_MAIN())
    lvgl.obj_set_style_text_color(ui.edit_btn_back_label, lvgl.color_white(), lvgl.PART_MAIN())
    lvgl.obj_set_style_text_font(ui.edit_btn_back_label, lvgl.font_montserrat_16(), lvgl.PART_MAIN())

    -- custom.lua will be called here if it exists and has a function for the edit screen
    -- if custom and custom.setup_scr_edit then
    --     custom.setup_scr_edit(ui)
    -- end

    lvgl.obj_update_layout(ui.edit)
    
    events_init.events_init_edit(ui)
end

return setup_scr_edit
