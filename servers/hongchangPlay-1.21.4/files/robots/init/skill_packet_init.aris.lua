-- 룰렛
local roulette_result_s2c = aris.init.networking.create_s2c_packet("roulette_result")
roulette_result_s2c:append(aris.init.networking.string_arg("data1"))
roulette_result_s2c:append(aris.init.networking.string_arg("data2"))
roulette_result_s2c:append(aris.init.networking.string_arg("data3"))
roulette_result_s2c:append(aris.init.networking.string_arg("data4"))
roulette_result_s2c:append(aris.init.networking.string_arg("msg"))

local roulette_complete_c2s = aris.init.networking.create_c2s_packet("roulette_complete")
roulette_complete_c2s:append(aris.init.networking.string_arg("done"))

-- 마을 선택
local village_selection_gui_s2c = aris.init.networking.create_s2c_packet("village_selection_gui")
village_selection_gui_s2c:append(aris.init.networking.string_arg("villages"))

local village_selection_c2s = aris.init.networking.create_c2s_packet("village_selection")
village_selection_c2s:append(aris.init.networking.string_arg("selectedvillage"))

-- hud
local hud_info_s2c = aris.init.networking.create_s2c_packet("hud_info")
hud_info_s2c:append(aris.init.networking.string_arg("displayName"))
hud_info_s2c:append(aris.init.networking.string_arg("money"))
hud_info_s2c:append(aris.init.networking.string_arg("villageName"))

-- 이미지
local img_s2c = aris.init.networking.create_s2c_packet("img")
img_s2c:append(aris.init.networking.string_arg("img_url"))
img_s2c:append(aris.init.networking.string_arg("width"))
img_s2c:append(aris.init.networking.string_arg("height"))
img_s2c:append(aris.init.networking.string_arg("x"))
img_s2c:append(aris.init.networking.string_arg("y"))
img_s2c:append(aris.init.networking.string_arg("scale"))


-- 미니게임

local game_s2c = aris.init.networking.create_s2c_packet("game")
game_s2c:append(aris.init.networking.string_arg("type"))

local game_c2s = aris.init.networking.create_c2s_packet("game")
game_c2s:append(aris.init.networking.string_arg("type"))