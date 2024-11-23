local mq					= require('mq')
local ImGui	    		    = require('ImGui')
local ICONS                 = require('mq.Icons')
local running 				= true
local openGUI, drawGUI		= true, true
local guiheader 			= 'Completionist: Gotta Complete Them All'
local tabclick			    = nil
local FLT_MIN, FLT_MAX 		= mq.NumericLimits_Float()
local totalDone             = ''
local CB_Needed             = false
local CB_Challenger         = true
local CB_Champion           = true
local CB_Collections        = true
local CB_Explorer           = true
local CB_Hunter             = true
local CB_Slayer             = true
local CB_Tradeskill         = true
local CB_Vanquisher         = true

local function print_msg(msg, ...) printf('\at[\ayComplete\at] \at' .. msg, ...) end
local function print_err(msg, ...) printf('\at[\ayComplete\at] \ar' .. msg, ...) end








local function getPctCompleted(data)
    local tmp = 0
    local total = mq.TLO.Achievement(data).ObjectiveCount()
    for ii = 1, total, 1 do
        if mq.TLO.Achievement(data).ObjectiveByIndex(ii).Completed() then
            tmp = tmp + 1
        end
    end
    totalDone = string.format('%d / %d', tmp, total)
    return tmp / total
end

local function rowData(data)
    for i = 1, #data, 1 do
        local isComplete = mq.TLO.Achievement(data[i]).Completed()
        if isComplete and CB_Needed then
        else
            ImGui.TableNextRow()
                ImGui.TableNextColumn()
                    local removeBeginnings = string.gsub(mq.TLO.Achievement(data[i]).Name(), "Hunter of ", "     ")
                    removeBeginnings = string.gsub(mq.TLO.Achievement(data[i]).Name(), "Mercenary of", "     ")
                    removeBeginnings = string.gsub(mq.TLO.Achievement(data[i]).Name(), "Partisan of ", "     ")
                    ImGui.TextWrapped(removeBeginnings)
                ImGui.TableNextColumn()
                    if isComplete then
                        ImGui.TextColored(ImVec4(1.0, 1.0, 0.0, 1.0), "Completed")
                    elseif mq.TLO.Achievement(data[i]).ObjectiveCount() == 1 then
                        ImGui.Text("Not Completed")
                    else
                        local x, y = ImGui.GetContentRegionAvail()
                        ImGui.PushStyleColor(ImGuiCol.PlotHistogram, 0.690, 0.553, 0.259, 0.5)
                        ImGui.PushStyleColor(ImGuiCol.FrameBg, 0.33, 0.33, 0.33, 0.5)
                        ImGui.ProgressBar(getPctCompleted(data[i]), x-4, 14, totalDone)
                        ImGui.PopStyleColor(2)
                    end
        end
    end
end

local function drawChallengerPanel()
    local c_id_Name         = 1
    local c_id_progress     = 2
    local c_count           = 2
    local expansion_name    = {"Challenger of The Burning Lands","Challenger of Night of Shadows"}
	local h_e20 = {}
	local h_e21 = {}
	local h_e22 = {}
	local h_e23 = {}
	local h_e24 = {}
	local h_e25 = {2681971,2681972,2681973,2682071,2682073,2682072,2682171,2682172,2682173,2681871,2681873,2681872,2682271,2682272,2682273,2682371,2682372,2682373,2681771,2681772,2681773,2681774,2681775,2681776,2681777,2681778,2681779,2681780,2681781,2681782,2681783,2681784,2681785}
	local h_e26 = {}
	local h_e27 = {}
	local h_e28 = {}
	local h_e29 = {3005111,3005112,3005113,3005311,3005312,3005313,3005411,3005412,3005413,3005211,3005212,3005213}
	local h_e30 = {}
    for x = 1, #expansion_name, 1 do
        local open = ImGui.CollapsingHeader(expansion_name[x], ImGuiTreeNodeFlags.None)
        if open and ImGui.BeginTable('Gchallengeseverquest', c_count, bit32.bor(ImGuiTableFlags.None)) then
            ImGui.TableSetupColumn('Challenger of', 0, 60, c_id_Name)
            ImGui.TableSetupColumn('Progress', 0, 60, c_id_progress)
            ImGui.TableSetupScrollFreeze(0, 1)
            ImGui.TableHeadersRow()
            if expansion_name[x] == "Vanquisher of Rain of Fear" then           rowData(h_e20) end
            if expansion_name[x] == "Vanquisher of The Darkened Sea" then       rowData(h_e21) end
            if expansion_name[x] == "Vanquisher of The Broken Mirror" then      rowData(h_e22) end
            if expansion_name[x] == "Vanquisher of The Empires of Kunark" then  rowData(h_e23) end
            if expansion_name[x] == "Vanquisher of The Ring of Scale" then      rowData(h_e24) end
            if expansion_name[x] == "Challenger of The Burning Lands" then      rowData(h_e25) end
            if expansion_name[x] == "Vanquisher of Torment of Velious" then     rowData(h_e26) end
            if expansion_name[x] == "Vanquisher of " then                       rowData(h_e27) end
            if expansion_name[x] == "Vanquisher of " then                       rowData(h_e28) end
            if expansion_name[x] == "Challenger of Night of Shadows" then       rowData(h_e29) end
            if expansion_name[x] == "Vanquisher of " then                       rowData(h_e30) end
            ImGui.EndTable()
        end
    end
end

local function drawChampionPanel()
    local c_id_Name         = 1
    local c_id_progress     = 2
    local c_count           = 2
    local expansion_name    = {"Champion of Burning Lands","Champion of Night of Shadows"}
	local h_e20 = {}
	local h_e21 = {}
	local h_e22 = {}
	local h_e23 = {}
	local h_e24 = {}
	local h_e25 = {}
    local h_e26 = {}
	local h_e27 = {}
	local h_e28 = {}
	local h_e29 = {3004710,3004733,3004731,3004732,3004720,3004610,3004620,3004110,3004120,3004410,3004420,3004510,3004520,3004210,3004220,3004310,3004320}
	local h_e30 = {}
    for x = 1, #expansion_name, 1 do
        local open = ImGui.CollapsingHeader(expansion_name[x], ImGuiTreeNodeFlags.None)
        if open and ImGui.BeginTable('questseverquest', c_count, bit32.bor(ImGuiTableFlags.None)) then
            ImGui.TableSetupColumn('Mercenary and Partisan of', 0, 60, c_id_Name)
            ImGui.TableSetupColumn('Progress', 0, 60, c_id_progress)
            ImGui.TableSetupScrollFreeze(0, 1)
            ImGui.TableHeadersRow()
            if expansion_name[x] == "Champion of Rain of Fear" then             rowData(h_e20) end
            if expansion_name[x] == "Champion of The Darkened Sea" then         rowData(h_e21) end
            if expansion_name[x] == "Champion of The Broken Mirror" then        rowData(h_e22) end
            if expansion_name[x] == "Champion of The Empires of Kunark" then    rowData(h_e23) end
            if expansion_name[x] == "Champion of The Ring of Scale" then        rowData(h_e24) end
            if expansion_name[x] == "Champion of The Burning Lands" then        rowData(h_e25) end
            if expansion_name[x] == "Champion of Torment of Velious" then       rowData(h_e26) end
            if expansion_name[x] == "Champion of " then                         rowData(h_e27) end
            if expansion_name[x] == "Champion of " then                         rowData(h_e28) end
            if expansion_name[x] == "Champion of Night of Shadows" then         rowData(h_e29) end
            if expansion_name[x] == "Champion of " then                         rowData(h_e30) end
            ImGui.EndTable()
        end
    end
end

local function drawCollectionsPanel()
    local c_id_Name         = 1
    local c_id_progress     = 2
    local c_count           = 2
    local expansion_name    = {"Everquest Collections","Year of Darkpaw","Master Scavenger of Fear","Call of the Forsaken Master Scavenger","Master Scavenger of The Darkened Sea","Master Scavenger of The Broken Mirror","Empires of Kunark Master Scavenger","Ring of Scale Master Scavenger","Burning Lands Master Scavenger","Torment of Velious Master Scavenger","Tundra Excavator","Shadow Seeker","Night Seeker","Song Seeker"}
    local h_everquest = {}
    local h_darkpaw = {}
	local h_e19 = {}
	local h_e20 = {}
	local h_e21 = {}
	local h_e22 = {}
	local h_e23 = {}
	local h_e24 = {}
	local h_e25 = {26082230,26081730,26082210,26082140,26081740,26081720,26082010,26082220,26081830,26082110,26081820,26082030,26082240,26081940,26082120,26081910,26082130,26082020,26081810,26081840,15078720,15078740,15078710,15078730,26082040,26081930,26081920,26081710}
	local h_e26 = {}
	local h_e27 = {2808363,2808242,2808352,2808112,2808354,2808233,2808351,2808231,2808122,2808244,2808234,2808361,2808123,2808114,2808124,2808121,2808232,2808353,2808111,2808362,2808241,2808113,2808364,2808243}
	local h_e28 = {2909241,2909352,2909362,2909372,2909124,2909113,2909243,2909363,2909122,2909371,2909121,2909374,2909111,2909364,2909233,2909114,2909231,2909361,2909232,2909353,2909242,2909351,2909234,2909354,2909123,2909373,2909112,2909244}
	local h_e29 = {3009362,3009233,3009363,3009373,3009234,3009351,3009113,3009244,3009372,3009121,3009114,3009112,3009123,3009374,3009122,3009111,3009124,3009364,3009361,3009243,3009232,3009371,3009242,3009353,3009354,3009231,3009352,3009241}
	local h_e30 = {}
    for x = 1, #expansion_name, 1 do
        local open = ImGui.CollapsingHeader(expansion_name[x], ImGuiTreeNodeFlags.None)
        if open and ImGui.BeginTable('collectionseverquest', c_count, bit32.bor(ImGuiTableFlags.None)) then
            ImGui.TableSetupColumn('Collection', 0, 60, c_id_Name)
            ImGui.TableSetupColumn('Progress', 0, 60, c_id_progress)
            ImGui.TableSetupScrollFreeze(0, 1)
            ImGui.TableHeadersRow()
            if expansion_name[x] == "Everquest Collections" then                    rowData(h_everquest) end
            if expansion_name[x] == "Year of Darkpaw" then                          rowData(h_darkpaw) end
            if expansion_name[x] == "Master Scavenger of Fear" then                 rowData(h_e19) end
            if expansion_name[x] == "Call of the Forsaken Master Scavenger" then    rowData(h_e20) end
            if expansion_name[x] == "Master Scavenger of The Darkened Sea" then     rowData(h_e21) end
            if expansion_name[x] == "Master Scavenger of The Broken Mirror" then    rowData(h_e22) end
            if expansion_name[x] == "Empires of Kunark Master Scavenger" then       rowData(h_e23) end
            if expansion_name[x] == "Ring of Scale Master Scavenger" then           rowData(h_e24) end
            if expansion_name[x] == "Burning Lands Master Scavenger" then           rowData(h_e25) end
            if expansion_name[x] == "Torment of Velious Master Scavenger" then      rowData(h_e26) end
            if expansion_name[x] == "Tundra Excavator" then                         rowData(h_e27) end
            if expansion_name[x] == "Shadow Seeker" then                            rowData(h_e28) end
            if expansion_name[x] == "Night Seeker" then                             rowData(h_e29) end
            if expansion_name[x] == "Song Seeker" then                              rowData(h_e30) end
            ImGui.EndTable()
        end
    end
end

local function drawExplorerPanel()
    local c_id_Name         = 1
    local c_id_progress     = 2
    local c_count           = 2
    local expansion_name    = {"Explorer of Night of Shadows"}
    local h_everquest = {}
    local h_e1 = {}
    local h_e2 = {}
	local h_e3 = {}
	local h_e4 = {}
	local h_e5 = {}
	local h_e6 = {}
	local h_e7 = {}
	local h_e8 = {}
	local h_e9 = {}
	local h_e10 = {}
	local h_e11 = {}
	local h_e12 = {}
	local h_e13 = {}
	local h_e14 = {}
	local h_e15 = {}
	local h_e16 = {}
	local h_e17 = {}
	local h_e18 = {}
	local h_e19 = {}
	local h_e20 = {}
	local h_e21 = {}
	local h_e22 = {}
	local h_e23 = {}
	local h_e24 = {}
	local h_e25 = {2681900,2682000,2682100,2682200,2681800,2682300,2681700}
	local h_e26 = {}
	local h_e27 = {}
	local h_e28 = {}
	local h_e29 = {3003700,3003600,3003100,3003400,3003500,3003200,3003300}
	local h_e30 = {}
	local h_e31 = {}
    for x = 1, #expansion_name, 1 do
        local open = ImGui.CollapsingHeader(expansion_name[x], ImGuiTreeNodeFlags.None)
        if open and ImGui.BeginTable('exploreeverquest', c_count, bit32.bor(ImGuiTableFlags.None)) then
            ImGui.TableSetupColumn('Explore', 0, 60, c_id_Name)
            ImGui.TableSetupColumn('Progress', 0, 60, c_id_progress)
            ImGui.TableSetupScrollFreeze(0, 1)
            ImGui.TableHeadersRow()
            if expansion_name[x] == "Norrathian Slayer" then            rowData(h_everquest) end
            if expansion_name[x] == "Ruinslayer" then                   rowData(h_e1) end
            if expansion_name[x] == "Scarslayer" then                   rowData(h_e2) end
            if expansion_name[x] == "Moonslayer" then                   rowData(h_e3) end
            if expansion_name[x] == "Planeslayer" then                  rowData(h_e4) end
            if expansion_name[x] == "Pirate Slayer" then                rowData(h_e5) end
            if expansion_name[x] == "Dungeon Slayer" then               rowData(h_e6) end
            if expansion_name[x] == "Gatebreaker" then                  rowData(h_e7) end
            if expansion_name[x] == "Omenslayer" then                   rowData(h_e8) end
            if expansion_name[x] == "Dragon Slayer" then                rowData(h_e9) end
            if expansion_name[x] == "Deepslayer" then                   rowData(h_e10) end
            if expansion_name[x] == "Slayer of Prophecy" then           rowData(h_e11) end
            if expansion_name[x] == "Spinebreaker" then                 rowData(h_e12) end
            if expansion_name[x] == "Brineslayer" then                  rowData(h_e13) end
            if expansion_name[x] == "Slayer of Secrets" then            rowData(h_e14) end
            if expansion_name[x] == "Voidslayer" then                   rowData(h_e15) end
            if expansion_name[x] == "Firstslayer" then                  rowData(h_e16) end
            if expansion_name[x] == "Dreamslayer" then                  rowData(h_e17) end
            if expansion_name[x] == "Veilslayer" then                   rowData(h_e18) end
            if expansion_name[x] == "Fearslayer" then                   rowData(h_e19) end
            if expansion_name[x] == "Call of the Forsaken Slayer" then  rowData(h_e20) end
            if expansion_name[x] == "Seaslayer" then                    rowData(h_e21) end
            if expansion_name[x] == "Mirror Slayer" then                rowData(h_e22) end
            if expansion_name[x] == "The Empires of Kunark Slayer" then rowData(h_e23) end
            if expansion_name[x] == "The Ring of Scale Slayer" then     rowData(h_e24) end
            if expansion_name[x] == "Burnslayer" then                   rowData(h_e25) end
            if expansion_name[x] == "Restless Slayer" then              rowData(h_e26) end
            if expansion_name[x] == "Ice Cold Slayer" then              rowData(h_e27) end
            if expansion_name[x] == "Shadow Slayer" then                rowData(h_e28) end
            if expansion_name[x] == "Explorer of Night of Shadows" then rowData(h_e29) end
            if expansion_name[x] == "Mythslayer" then                   rowData(h_e30) end
            if expansion_name[x] == "Broodslayer" then                  rowData(h_e31) end
            ImGui.EndTable()
        end
    end
end

local function drawHunterPanel()
    local c_id_Name         = 1
    local c_id_progress     = 2
    local c_count           = 2
    local expansion_name    = {"Norrathian Slayer", "Ruinslayer", "Scarslayer","Moonslayer","Planeslayer","Pirate Slayer","Dungeon Slayer","Gatebreaker","Omenslayer","Dragon Slayer","Deepslayer","Slayer of Prophecy","Spinebreaker","Brineslayer","Slayer of Secrets","Voidslayer","Firstslayer","Dreamslayer","Veilslayer","Fearslayer","Call of the Forsaken Slayer","Seaslayer","Mirror Slayer","The Empires of Kunark Slayer","The Ring of Scale Slayer","Burnslayer","Restless Slayer","Ice Cold Slayer","Shadow Slayer","Nightslayer","Mythslayer","Broodslayer"}
    local h_everquest = {154880,103680,106880,105880,107080,103080,100090,138480,140780,118180,106480,105180,103280,104480,118280,139280,100105,100101,100095,103180,139380,100110,100115,104880,105980,127880,106580,106380,104780,101680,153980,151880,101880,102780,105780,101180,141580,101380,140980,107380,100120,158680,104580,100480,105080,106680,103980,101480,144880,110080,110180,101280,141480}
    local h_e1      = {210380,227780,209280,208880,210280,209780,208580,208780,209080,210480,208680,209480,207880,210580,260780,208980,208380,208180,207980,209680,209580,210880,210980,250880}
    local h_e2      = {311780,312380,311680,312980,311380,312580,380380,312180,311880,311080,352680,380280,311180,311980,312080,311280}
	local h_e3      = {416380,480980,416680,416880,416180,416580,416280,415480,417980,417480,416480,415380,415780,417180,417380,415680,417580,417280,417080,417680,415880}
	local h_e4      = {521780,521480,521580,521180,522180,520580,520680,520180,520480,521080,521303,520880,521680,520080,522080,521280,520980,520780,521880}
	local h_e5      = {622580,622880,127880,622780,622480,622680}
	local h_e6      = {742880,743980,715380,746180,745080,716480,735180,749480,739580,701080,704380,738480,721980,731880,710980,709880,723080,713180,726380,730780,705480,728580,725280,717580,751680,748380,706580,736280,734080,719780,752780,708780,741780,720880,750580,732980,724180,737380,718680,729680,727480,707680,703280,714280,702180,740680,747280,712080}
	local h_e7      = {808600,808400,808800,808100,808200,808000,808300,808500,808700,808900}
	local h_e8      = {908600,908300,908100,908200,908900,908400,908024,908700,908500,908800,908000}
	local h_e9      = {1008200,1008400,1008700,1008500,1008100,1008600,1008300}
	local h_e10     = {1108100,1108200,1108800,1108700,1108400,1108500,1108300}
	local h_e11     = {1208300,1208400,1208100,1208600,1208200,1208500}
	local h_e12     = {1308019,1308400,1308100,1308800,1308000,1308057,1308300,1308900,1308200,1308600,1308500,1308035,1308700}
	local h_e13     = {1408100,1408600,1408700,1408800,1408500,1408400,1408900}
	local h_e14     = {1508900,1508000,1508100,1508400,1578780,1508018,1508300,1508800,1508500,1508700,1508200,1508600}
	local h_e15     = {1646860,1645660,1645260,1647060,1645560,1646660,1646760,1647260,1647460,1645760,1645460,1645360,1647660,1647760,1646960,1647560}
	local h_e16     = {1708500,1708100,1708000,1708400,1708600,1708300,1708900,1708008,1708200,1708800,1708700,1708031}
	local h_e17     = {1870960,1870660,1871160,1871060,1870760,1870860,1870060,1870360,1870160,1870260,1870460,1870560}
	local h_e18     = {1972460,1973260,1972760,1972660,1972860,1973060,1972960,1973360,1972560,1973160}
	local h_e19     = {2076375,2075580,2075880,2075980,2075480,2075280,2075780,2076080,2075680,2076540,2076455,2075381}
	local h_e20     = {2177670,2177070,2177071,2104370,2104371,2177170,2177570,2177270,2177271}
	local h_e21     = {2277880,2277980,2278280,2278180,2278480,2278080,2278580,2278380}
	local h_e22     = {2379680,2379580,2320180,2379880,2320190,2379780,2377780}
	local h_e23     = {2480080,2479180,2479380,2479980,2479480,2479080,2478880}
	local h_e24     = {2579280,2578980,2581380,2581580,2581480,2581680}
	local h_e25     = {2681980,2682080,2682180,2682280,2681880,2681790}
	local h_e26     = {2783080,2782980,2782480,2782780,2782680,2782580,2782880}
	local h_e27     = {2807101,2807401,2807501,2807601,2807301,2807201}
	local h_e28     = {2908600,2908700,2908300,2908100,2908500,2908200,2908400}
	local h_e29     = {3008700,3008600,3008100,3008400,3008500,3008200,3008300}
	local h_e30     = {31080300,31080100,31080400,31080700,31080600,31080200,31080500}
	local h_e31     = {}
    for x = 1, #expansion_name, 1 do
        local open = ImGui.CollapsingHeader(expansion_name[x], ImGuiTreeNodeFlags.None)
        if open and ImGui.BeginTable('huntereverquest', c_count, bit32.bor(ImGuiTableFlags.None)) then
            ImGui.TableSetupColumn('Hunter of', 0, 60, c_id_Name)
            ImGui.TableSetupColumn('Progress', 0, 60, c_id_progress)
            ImGui.TableSetupScrollFreeze(0, 1)
            ImGui.TableHeadersRow()
            if expansion_name[x] == "Norrathian Slayer" then            rowData(h_everquest) end
            if expansion_name[x] == "Ruinslayer" then                   rowData(h_e1) end
            if expansion_name[x] == "Scarslayer" then                   rowData(h_e2) end
            if expansion_name[x] == "Moonslayer" then                   rowData(h_e3) end
            if expansion_name[x] == "Planeslayer" then                  rowData(h_e4) end
            if expansion_name[x] == "Pirate Slayer" then                rowData(h_e5) end
            if expansion_name[x] == "Dungeon Slayer" then               rowData(h_e6) end
            if expansion_name[x] == "Gatebreaker" then                  rowData(h_e7) end
            if expansion_name[x] == "Omenslayer" then                   rowData(h_e8) end
            if expansion_name[x] == "Dragon Slayer" then                rowData(h_e9) end
            if expansion_name[x] == "Deepslayer" then                   rowData(h_e10) end
            if expansion_name[x] == "Slayer of Prophecy" then           rowData(h_e11) end
            if expansion_name[x] == "Spinebreaker" then                 rowData(h_e12) end
            if expansion_name[x] == "Brineslayer" then                  rowData(h_e13) end
            if expansion_name[x] == "Slayer of Secrets" then            rowData(h_e14) end
            if expansion_name[x] == "Voidslayer" then                   rowData(h_e15) end
            if expansion_name[x] == "Firstslayer" then                  rowData(h_e16) end
            if expansion_name[x] == "Dreamslayer" then                  rowData(h_e17) end
            if expansion_name[x] == "Veilslayer" then                   rowData(h_e18) end
            if expansion_name[x] == "Fearslayer" then                   rowData(h_e19) end
            if expansion_name[x] == "Call of the Forsaken Slayer" then  rowData(h_e20) end
            if expansion_name[x] == "Seaslayer" then                    rowData(h_e21) end
            if expansion_name[x] == "Mirror Slayer" then                rowData(h_e22) end
            if expansion_name[x] == "The Empires of Kunark Slayer" then rowData(h_e23) end
            if expansion_name[x] == "The Ring of Scale Slayer" then     rowData(h_e24) end
            if expansion_name[x] == "Burnslayer" then                   rowData(h_e25) end
            if expansion_name[x] == "Restless Slayer" then              rowData(h_e26) end
            if expansion_name[x] == "Ice Cold Slayer" then              rowData(h_e27) end
            if expansion_name[x] == "Shadow Slayer" then                rowData(h_e28) end
            if expansion_name[x] == "Nightslayer" then                  rowData(h_e29) end
            if expansion_name[x] == "Mythslayer" then                   rowData(h_e30) end
            if expansion_name[x] == "Broodslayer" then                  rowData(h_e31) end
            ImGui.EndTable()
        end
    end
end

local function drawSlayerPanel()
end

local function drawTradeskillPanel()
end

local function drawVanquisherPanel()
    local c_id_Name         = 1
    local c_id_progress     = 2
    local c_count           = 2
    local expansion_name    = {"Vanquisher of Night of Shadows"}
	local h_e20             = {}
	local h_e21             = {}
	local h_e22             = {}
	local h_e23             = {}
	local h_e24             = {}
	local h_e25             = {}
	local h_e26             = {}
	local h_e27             = {}
	local h_e28             = {}
	local h_e29             = {3007111,3007112,3007113,3007211,3007212,3007213,3007311,3007312,3007313,3007411,3007412,3007413,3007511,3007512,3007513,3007521,3007522,3007523,3007611,3007612,3007613,3007711,3007712,3007713,3007811,3007812,3007813}
	local h_e30             = {}
    for x = 1, #expansion_name, 1 do
        local open = ImGui.CollapsingHeader(expansion_name[x], ImGuiTreeNodeFlags.None)
        if open and ImGui.BeginTable('Rchallengeseverquest', c_count, bit32.bor(ImGuiTableFlags.None)) then
            ImGui.TableSetupColumn('Vanquisher of', 0, 60, c_id_Name)
            ImGui.TableSetupColumn('Progress', 0, 60, c_id_progress)
            ImGui.TableSetupScrollFreeze(0, 1)
            ImGui.TableHeadersRow()
            if expansion_name[x] == "Vanquisher of Rain of Fear" then           rowData(h_e20) end
            if expansion_name[x] == "Vanquisher of The Darkened Sea" then       rowData(h_e21) end
            if expansion_name[x] == "Vanquisher of The Broken Mirror" then      rowData(h_e22) end
            if expansion_name[x] == "Vanquisher of The Empires of Kunark" then  rowData(h_e23) end
            if expansion_name[x] == "Vanquisher of The Ring of Scale" then      rowData(h_e24) end
            if expansion_name[x] == "Vanquisher of The Burning Lands" then      rowData(h_e25) end
            if expansion_name[x] == "Vanquisher of Torment of Velious" then     rowData(h_e26) end
            if expansion_name[x] == "Vanquisher of " then                       rowData(h_e27) end
            if expansion_name[x] == "Vanquisher of " then                       rowData(h_e28) end
            if expansion_name[x] == "Vanquisher of Night of Shadows" then       rowData(h_e29) end
            if expansion_name[x] == "Vanquisher of " then                       rowData(h_e30) end
            ImGui.EndTable()
        end
    end
end

local function drawEventsPanel()
    local c_id_Name     = 1
    local c_id_Person   = 2
    local c_id_Helper   = 2
    local c_count       = 3
    local open = ImGui.CollapsingHeader(expansion_name[x], ImGuiTreeNodeFlags.None)
        if open and ImGui.BeginTable('event_starts', c_count, bit32.bor(ImGuiTableFlags.None)) then
            ImGui.TableSetupColumn('Event', 0, 60, c_id_Name)
            ImGui.TableSetupColumn('Named', 0, 60, c_id_Person)
            ImGui.TableSetupColumn('Helper', 0, 60, c_id_Helper)
            ImGui.TableSetupScrollFreeze(0, 1)
            ImGui.TableHeadersRow()
            ImGui.EndTable()
        end
end

local function DrawPanels(data)
	if data == 'Challenger' then    drawChallengerPanel() end
	if data == 'Champion' then      drawChampionPanel() end
	if data == 'Collections' then   drawCollectionsPanel() end
	if data == 'Explorer' then      drawExplorerPanel() end
	if data == 'Hunter' then        drawHunterPanel() end
	if data == 'Slayer' then        drawSlayerPanel() end
	if data == 'Tradeskill' then    drawTradeskillPanel() end
	if data == 'Vanquisher' then    drawVanquisherPanel() end
	if data == 'Events' then        drawEventsPanel() end
end

local function DrawATab(data)
	if ImGui.BeginTabItem(data) then
		tabclick = data
		ImGui.EndTabItem()
	end
end

local function MenuSettings()
    if ImGui.BeginPopupContextItem('Settings') then
        ImGui.SeparatorText('Settings')
        CB_Needed = ImGui.Checkbox('Only show needed achievements', CB_Needed)
        ImGui.SeparatorText('Tabs')
        CB_Challenger   = ImGui.Checkbox('Challenger',  CB_Challenger)
        CB_Champion     = ImGui.Checkbox('Challenger',  CB_Champion)
        CB_Collections  = ImGui.Checkbox('Collections', CB_Collections)
        CB_Explorer     = ImGui.Checkbox('Explorer',    CB_Explorer)
        CB_Hunter       = ImGui.Checkbox('Hunter',      CB_Hunter)
        CB_Slayer       = ImGui.Checkbox('Slayer',      CB_Slayer)
        CB_Tradeskill   = ImGui.Checkbox('Tradeskill',  CB_Tradeskill)
        CB_Vanquisher   = ImGui.Checkbox('Vanquisher',  CB_Vanquisher)
        CB_Events       = ImGui.Checkbox('Events',  CB_Events)
        ImGui.EndPopup()
    end
end

local function DisplayGUI()
	if not openGUI then
		running = false
	end
	ImGui.SetNextWindowPos(400, 400, ImGuiCond.Once)
    ImGui.SetNextWindowSize(800, 650, ImGuiCond.Once)
	ImGui.SetNextWindowSizeConstraints(ImVec2(650, 250), ImVec2(FLT_MAX, FLT_MAX))
	openGUI, drawGUI = ImGui.Begin(guiheader, openGUI, bit32.bor(ImGuiWindowFlags.None))
	if drawGUI and not mq.TLO.Me.Zoning() then
        ImGui.SmallButton(ICONS.MD_SETTINGS)
        ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 10, 10)
        MenuSettings()
        ImGui.SameLine()
		if ImGui.BeginTabBar('CompleteTabs', bit32.bor(ImGuiTabBarFlags.None)) then
			if CB_Challenger then   DrawATab('Challenger') end
			if CB_Champion then     DrawATab('Champion') end
			if CB_Collections then  DrawATab('Collections') end
			if CB_Explorer then     DrawATab('Explorer') end
			if CB_Hunter then       DrawATab('Hunter') end
			if CB_Slayer then       DrawATab('Slayer') end
			if CB_Tradeskill then   DrawATab('Tradeskill') end
			if CB_Vanquisher then   DrawATab('Vanquisher') end
			if CB_Events then       DrawATab('Events') end
			ImGui.EndTabBar()
		end
        ImGui.BeginChild('Panels', 0, bit32.bor(ImGuiChildFlags.None))
		    DrawPanels(tabclick)
        ImGui.EndChild()
	end
	ImGui.End()
end

local function initialize()
	--Define trigger events to update filterdata
	--mq.event('SomeoneKills','#*#has been slain by#*#',DeathCheckUpdate)
	--mq.event('YouKill','#*#You have slain#*#',DeathCheckUpdate)

	--check for plugins that are used in this script
	--for _, plugin in ipairs(plugins) do
	--	if mq.TLO.Plugin(plugin)() == nil then
	--		printf('"\ar%s \aois required for this script.', plugin)
	--		printf('\aoLoaded \ar%s \aowith \agnoauto\ao.', plugin)
	--		mq.cmdf('/plugin %s noauto', plugin)
	--	end
	--end
	--class_settings.loadSettings()
	mq.imgui.init('drawGUI', DisplayGUI)
end

initialize()

while running == true do
	mq.delay('1s')
end