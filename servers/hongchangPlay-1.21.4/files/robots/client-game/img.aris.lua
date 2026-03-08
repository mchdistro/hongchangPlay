local hud = aris.game.client.create_hud()
hud:open_hud()

aris.game.client.networking.register_s2c_packet_handler("img", function(v)
    if v.img_url == "" then
        hud:clear_child()
    else
        hud:clear_child()
        local img = aris.client.create_image_renderer(aris.client.load_image(v.img_url))
        img:set_width(1920)
        img:set_height(1080)

        local w = tonumber(v.width)
        local h = tonumber(v.height)
        local x = tonumber(v.x)
        local y = tonumber(v.y)
        local scale = tonumber(v.scale)
        if w then img:set_width(w) end
        if h then img:set_height(h) end
        if x then img:set_x(x) end
        if y then img:set_y(y) end
        if scale then img:set_scale(scale) end
        hud:add_child(img)
    end
end)
