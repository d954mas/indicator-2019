local COMMON = require "libs.common"

local FACTORY_REGION_URL = msg.url("game:/factories#factory_region")
local FACTORY_EMPTY_URL = msg.url("game:/factories#factory_empty")
local FACTORY_FIGURE_URL = msg.url("game:/factories#factory_figure")
---@class Level
local Lvl = COMMON.class("Level")

function Lvl:initialize()
    ---@type Region[]
    self.regions = {}
    ---@type Region[]
    self.figures = {}
    self.targets = {
        0.60, 0.80, 0.95
    }
end

function Lvl:create_go(factory_url,position,scale,image)
    local go_url = msg.url(factory.create(factory_url,position,nil,nil,scale))
    if image then
        local sprite_url = msg.url(go_url)
        sprite_url.fragment = "sprite"
        sprite.play_flipbook(sprite_url,image)
    end
    if self.go_root then
        go.set_parent(go_url,self.go_root)
    end
    return go_url
end

function Lvl:load()
    self.go_root = self:create_go(FACTORY_EMPTY_URL)
    self.go_regions = {}
    self.go_figures = {}
    for _, region in ipairs(self.regions) do
        local go_url = self:create_go(FACTORY_REGION_URL,region.position,region.scale,hash(region.art))
        table.insert(self.go_regions,go_url)
        local sprite_url = msg.url(go_url)
        sprite_url.fragment = "sprite_mask"
        sprite.play_flipbook(sprite_url,hash(region.art))
    end
    for _, region in ipairs(self.figures) do
        region.position.z = 0.01
        local url = self:create_go(FACTORY_FIGURE_URL,region.position,region.scale,region.art)
        local sprite_url = msg.url(url.socket,url.path,"sprite")
        sprite.set_constant(sprite_url,"tint",vmath.vector4(1,0,0,1))
        table.insert(self.go_figures,url)
    end
end

function Lvl:unload()
    if self.go_root then
        go.delete(self.go_root,true)
        self.go_root = false
        self.go_regions = {}
    end
end

return Lvl