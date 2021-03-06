local BaseLvl = require "assets.levels.level"
local Region = require "assets.levels.region"

local Lvl = BaseLvl:subclass("Lvl1")

function Lvl:initialize(...)
    BaseLvl.initialize(self,...)
    self.regions = {
        Region("region_circle",0,0,2.7)
    }

    self.figures = {
        Region("rect",0,0,0.4)
    }
end

return Lvl