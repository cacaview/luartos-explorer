
--
-- Copyright 2025 NXP
-- NXP Proprietary. This software is owned or controlled by NXP and may only be used strictly in
-- accordance with the applicable license terms. By expressly accepting such terms or by downloading, installing,
-- activating and/or otherwise using the software, you are agreeing that you have read, and that you agree to
-- comply with and are bound by, such license terms.  If you do not agree to be bound by the applicable license
-- terms, then you may not retain, install, activate or otherwise use the software.
--

local setup_scr_file = {}

local events_init = require("events_init")
-- local custom = require("custom")

-- Helper function to create and apply styles, mimicking the C approach
local function create_and_apply_style(obj, properties, part)
    for prop, value in pairs(properties) do
        local style_setter = lvgl["obj_set_style_" .. prop]
        if style_setter then
            style_setter(obj, value, part)
        else
            print("Warning: style setter for " .. prop .. " not found.")
        end
    end
end

function setup_scr_file.setup_scr_file(ui)
    -- Create screen: file
    ui.file = lvgl.obj_create(nil)
    lvgl.obj_set_size(ui.file, 480, 320)
    lvgl.obj_set_scrollbar_mode(ui.file, lvgl.SCROLLBAR_MODE_OFF())
    lvgl.obj_set_style_bg_opa(ui.file, 0, lvgl.PART_MAIN())

    -- Create container: file_cont_1
    ui.file_cont_1 = lvgl.obj_create(ui.file)
    lvgl.obj_set_pos(ui.file_cont_1, 1, 0)
    lvgl.obj_set_size(ui.file_cont_1, 480, 320)
    lvgl.obj_set_scrollbar_mode(ui.file_cont_1, lvgl.SCROLLBAR_MODE_OFF())
    local cont_style = {
        border_width = 2,
        border_color = lvgl.color_hex(0x2195f6),
        radius = 0,
        pad_all = 0
    }
    create_and_apply_style(ui.file_cont_1, cont_style, lvgl.PART_MAIN())

    -- Create list: file_file_list
    ui.file_file_list = lvgl.list_create(ui.file_cont_1)
    ui.file_file_list_item0 = lvgl.list_add_btn(ui.file_file_list, lvgl.SYMBOL_DIRECTORY(), "directory")
    ui.file_file_list_item1 = lvgl.list_add_btn(ui.file_file_list, lvgl.SYMBOL_FILE(), "file")
    ui.file_file_list_item2 = lvgl.list_add_btn(ui.file_file_list, lvgl.SYMBOL_FILE(), "file")
    lvgl.obj_set_pos(ui.file_file_list, 35, 85)
    lvgl.obj_set_size(ui.file_file_list, 410, 200)

    -- Create list: file_operate (initially hidden, shown on long press)
    ui.file_operate = lvgl.list_create(ui.file_cont_1)
    lvgl.list_add_btn(ui.file_operate, lvgl.SYMBOL_COPY(), "copy")
    lvgl.list_add_btn(ui.file_operate, lvgl.SYMBOL_CUT(), "cut")
    lvgl.list_add_btn(ui.file_operate, lvgl.SYMBOL_TRASH(), "delete")
    lvgl.list_add_btn(ui.file_operate, lvgl.SYMBOL_PASTE(), "paste")
    ui.file_operate_item4 = lvgl.list_add_btn(ui.file_operate, lvgl.SYMBOL_EDIT(), "edit")
    ui.file_operate_item5 = lvgl.list_add_btn(ui.file_operate, lvgl.SYMBOL_CLOSE(), "cancel")
    lvgl.obj_set_pos(ui.file_operate, 152, 118)
    lvgl.obj_set_size(ui.file_operate, 158, 153)
    lvgl.obj_add_flag(ui.file_operate, lvgl.OBJ_FLAG_HIDDEN())

    -- Create spangroup: file_spangroup_1
    ui.file_spangroup_1 = lvgl.spangroup_create(ui.file_cont_1)
    lvgl.obj_set_pos(ui.file_spangroup_1, 126, 22)
    lvgl.obj_set_size(ui.file_spangroup_1, 196, 30)
    local span = lvgl.spangroup_new_span(ui.file_spangroup_1)
    lvgl.span_set_text(span, "file")
    -- Style would be applied here

    -- Create button: file_btn_back
    ui.file_btn_back = lvgl.btn_create(ui.file_cont_1)
    lvgl.obj_set_pos(ui.file_btn_back, 17, 20)
    lvgl.obj_set_size(ui.file_btn_back, 65, 40)
    ui.file_btn_back_label = lvgl.label_create(ui.file_btn_back)
    lvgl.label_set_text(ui.file_btn_back_label, "back")
    lvgl.obj_center(ui.file_btn_back_label)
    local btn_style = {
        bg_color = lvgl.color_hex(0x2195f6),
        radius = 5,
        text_color = lvgl.color_white(),
        text_font = lvgl.font_montserrat_16()
    }
    create_and_apply_style(ui.file_btn_back, btn_style, lvgl.PART_MAIN())


    lvgl.obj_update_layout(ui.file)
    
    events_init.events_init_file(ui)
end

return setup_scr_file
