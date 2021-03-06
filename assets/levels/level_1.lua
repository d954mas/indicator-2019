local BaseLvl = require "assets.levels.level"
local Region = require "assets.levels.region"

local Lvl = BaseLvl:subclass("Lvl1")

function Lvl:initialize(...)
    BaseLvl.initialize(self,...)
    self.regions = {
        Region("region_1",0,0,2)
    }

    self.figures = {
        Region("rect",-100,-100,1)
    }
end

return Lvl