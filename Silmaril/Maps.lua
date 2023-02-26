--This allows for game changes in some buff ID'spell maps if they occur.
--This is a one time call that allows Silmaril to fix buffs
function buff_maps(all_spells)
local index = {
	[539] = "Geomancy Regen",
	[540] ="Geomancy Poison",
	[541] ="Geomancy Refresh",
	[580] ="Geomancy Haste",
	[542] ="Geomancy STR Boost",
	[543] ="Geomancy DEX Boost",
	[544] ="Geomancy VIT Boost",
	[545] ="Geomancy AGI Boost",
	[546] ="Geomancy INT Boost",
	[547] ="Geomancy MND Boost",
	[548] ="Geomancy CHR Boost",
	[549] ="Geomancy Attack Boost",
	[550] ="Geomancy Defense Boost",
	[551] ="Geomancy Magic Atk. Boost",
	[552] ="Geomancy Magic Def. Boost",
	[553] ="Geomancy Accuracy Boost",
	[554] ="Geomancy Evasion Boost",
	[555] ="Geomancy Magic Acc. Boost",
	[556] ="Geomancy Magic Evasion Boost",
	[557] ="Geomancy Attack Down",
	[558] ="Geomancy Defense Down",
	[559] ="Geomancy Magic Atk. Down",
	[560] ="Geomancy Magic Def. Down",
	[561] ="Geomancy Accuracy Down",
	[562] ="Geomancy Evasion Down",
	[563] ="Geomancy Magic Acc. Down",
	[564] ="Geomancy Magic Evasion Down",
	[565] ="Geomancy Slow",
	[566] ="Geomancy Paralysis",
	[567] ="Geomancy Weight",}
	log('buff_maps called')
    for id, buff in pairs (all_spells) do
        if index[buff.id] then
			--log('Remapping ['..all_spells[id].en..'] to ['..index[id]..']')
			all_spells[id].en = index[id]
        end
    end
end