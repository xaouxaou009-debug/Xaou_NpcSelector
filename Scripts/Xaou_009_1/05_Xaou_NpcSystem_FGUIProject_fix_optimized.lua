-- ============================================================
-- Xaou NPC Selector (UI Addon)
-- ม็อดแยกตัวนี้ทำหน้าที่เป็น UI/Selector เท่านั้น
-- ม็อดหลักเรียกด้วย: Xaou_NpcSelector.Open(callback)
-- ข้อมูลตั้งต้น: รายชื่อ NPC จากม็อดจีน
-- ============================================================

_G.Xaou_NpcSelector = _G.Xaou_NpcSelector or {}
local M = _G.Xaou_NpcSelector

M.packagePath = "UI/Xaou_NpcSelector"
M.packageName = "Xaou_NpcSelector"
M.componentName = "ComNpcSelector"

M.view = nil
M._portraitSlots = {}
M.page = 1
M.pageSize = 3
M.selectedIndex = 1
M.onSelectCallback = nil
M.filteredData = nil
M.searchKeyword = ""

M.data = {
    { id=990009001, seed=990009001, fakeId=990009001, recruitId=990009001, name="จื่อเซวียน", last="จื่อ", first="เซวียน", sex=2, sexText="หญิง", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="紫萱", desc="Xaou Prototype - จื่อเซวียน (紫萱)", portrait="Spr/Npc/zx.png", race="Human" },
    { id=990009002, seed=990009002, fakeId=990009002, recruitId=990009002, name="ถังเสวี่ยเจี้ยน", last="ถัง", first="เสวี่ยเจี้ยน", sex=2, sexText="หญิง", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="唐雪见", desc="Xaou Prototype - ถังเสวี่ยเจี้ยน (唐雪见)", portrait="Spr/Npc/xj_1.png", race="Human" },
    { id=990009003, seed=990009003, fakeId=990009003, recruitId=990009003, name="จิ่งเทียน", last="จิ่ง", first="เทียน", sex=1, sexText="ชาย", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="景天", desc="Xaou Prototype - จิ่งเทียน (景天)", portrait="Spr/Npc/jt_1.png", race="Human" },
    { id=990009004, seed=990009004, fakeId=990009004, recruitId=990009004, name="สวีฉางชิง", last="สวี", first="ฉางชิง", sex=1, sexText="ชาย", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="徐长卿", desc="Xaou Prototype - สวีฉางชิง (徐长卿)", portrait="Spr/Npc/cq_1.png", race="Human" },
    { id=990009005, seed=990009005, fakeId=990009005, recruitId=990009005, name="หลงขุย", last="หลง", first="ขุย", sex=2, sexText="หญิง", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="龙葵", desc="Xaou Prototype - หลงขุย (龙葵)", portrait="Spr/Npc/lk_1.png", race="Human" },
    { id=990009006, seed=990009006, fakeId=990009006, recruitId=990009006, name="หนานกงหวง", last="หนานกง", first="หวง", sex=1, sexText="ชาย", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="南宫煌", desc="Xaou Prototype - หนานกงหวง (南宫煌)", portrait="Spr/Npc/ngh_1.png", race="Human" },
    { id=990009007, seed=990009007, fakeId=990009007, recruitId=990009007, name="ซิงเสวียน", last="ซิง", first="เสวียน", sex=1, sexText="ชาย", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="星璇", desc="Xaou Prototype - ซิงเสวียน (星璇)", portrait="Spr/Npc/xx.png", race="Human" },
    { id=990009008, seed=990009008, fakeId=990009008, recruitId=990009008, name="เจียงขุย", last="เจียง", first="ขุย", sex=2, sexText="หญิง", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="姜葵", desc="Xaou Prototype - เจียงขุย (姜葵)", portrait="Spr/Npc/hlk.png", race="Human" },
    { id=990009010, seed=990009010, fakeId=990009010, recruitId=990009010, name="หวังเผิงซวี่", last="หวัง", first="เผิงซวี่", sex=2, sexText="หญิง", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="王蓬絮", desc="Xaou Prototype - หวังเผิงซวี่ (王蓬絮)", portrait="Spr/Npc/wpx.png", race="Human" },
    { id=990009011, seed=990009011, fakeId=990009011, recruitId=990009011, name="ฉงโหลว", last="ฉง", first="โหลว", sex=1, sexText="ชาย", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="重楼", desc="Xaou Prototype - ฉงโหลว (重楼)", portrait="Spr/Npc/cl.png", race="Human" },
    { id=990009012, seed=990009012, fakeId=990009012, recruitId=990009012, name="หลี่เซียวเหยา", last="หลี่", first="เซียวเหยา", sex=1, sexText="ชาย", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="李逍遥", desc="Xaou Prototype - หลี่เซียวเหยา (李逍遥)", portrait="Spr/Npc/lxy.png", race="Human" },
    { id=990009013, seed=990009013, fakeId=990009013, recruitId=990009013, name="จ้าวหลิงเอ๋อร์", last="จ้าว", first="หลิงเอ๋อร์", sex=2, sexText="หญิง", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="赵灵儿", desc="Xaou Prototype - จ้าวหลิงเอ๋อร์ (赵灵儿)", portrait="Spr/Npc/zle.png", race="Human" },
    { id=990009014, seed=990009014, fakeId=990009014, recruitId=990009014, name="หลินเยว่หรู", last="หลิน", first="เยว่หรู", sex=2, sexText="หญิง", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="林月如", desc="Xaou Prototype - หลินเยว่หรู (林月如)", portrait="Spr/Npc/lyr.png", race="Human" },
    { id=990009015, seed=990009015, fakeId=990009015, recruitId=990009015, name="อาหนู", last="อา", first="หนู", sex=2, sexText="หญิง", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="阿奴", desc="Xaou Prototype - อาหนู (阿奴)", portrait="Spr/Npc/anu.png", race="Human" },
    { id=990009016, seed=990009016, fakeId=990009016, recruitId=990009016, name="ซือถูจง", last="ซือถู", first="จง", sex=1, sexText="ชาย", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="司徒钟", desc="Xaou Prototype - ซือถูจง (司徒钟)", portrait="Spr/Npc/jjx.png", race="Human" },
    { id=990009050, seed=990009050, fakeId=990009050, recruitId=990009050, name="หลี่ไป๋", last="หลี่", first="ไป๋", sex=1, sexText="ชาย", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="司徒钟", desc="Xaou Prototype - ซือถูจง (司徒钟)", portrait="Spr/Npc/LiBai.png", race="Human" },
    { id=990009051, seed=990009051, fakeId=990009051, recruitId=990009051, name="จื่อเสีย", last="จื่อ", first="เสีย", sex=1, sexText="หญิง", age="16", sect="NPC จากม็อดXianJian/仙剑奇侠传自用2025Fix", source="reincarnate", cn="司徒钟", desc="Xaou Prototype - จื่อเสีย (司徒钟)", portrait="Spr/Npc/ZiXia.png", race="Human" },

}

-- Keep the bundled characters as a reliable fallback. Runtime discovery rebuilds
-- the visible list from this table so disabled/removed external mods do not leave
-- stale entries behind after a refresh.
M._builtinData = M.data
M.autoDiscoveredCount = 0
M.autoDiscoveryError = nil

-- ---------- Safe Helpers ----------
local function ShowMsg(msg)
    msg = tostring(msg or "")
    pcall(function()
        if world ~= nil and world.ShowMsgBox ~= nil then world:ShowMsgBox(msg) end
    end)
    pcall(function()
        if WorldLua ~= nil and WorldLua.ShowMsg ~= nil then WorldLua:ShowMsg(msg) end
    end)
    pcall(function()
        if CS ~= nil and CS.XiaWorld ~= nil and CS.XiaWorld.UI ~= nil then
            CS.XiaWorld.UI.InGameUI.Instance:ShowMsg(msg)
        end
    end)
end

local function UIPkg()
    if UIPackage ~= nil then return UIPackage end
    if CS ~= nil and CS.FairyGUI ~= nil then return CS.FairyGUI.UIPackage end
    return nil
end

local function Root()
    if GRoot ~= nil then return GRoot.inst end
    if CS ~= nil and CS.FairyGUI ~= nil and CS.FairyGUI.GRoot ~= nil then
        return CS.FairyGUI.GRoot.inst
    end
    return nil
end

local function GetChild(parent, name)
    if parent == nil or name == nil then return nil end
    local ok, obj = pcall(function() return parent:GetChild(name) end)
    if ok then return obj end
    return nil
end

local function SetText(obj, text)
    if obj == nil then return end
    text = tostring(text or "")
    pcall(function() obj.text = text end)
    pcall(function() obj.title = text end)
    pcall(function() if obj.m_title ~= nil then obj.m_title.text = text end end)
end

local function SetVisible(obj, value)
    if obj == nil then return end
    pcall(function() obj.visible = value end)
end


local function NormalizePortraitPath(path)
    path = tostring(path or "")
    if path == "" then return "" end
    path = string.gsub(path, "\\", "/")
    path = string.gsub(path, "^Resources/", "")
    return path
end

local function PortraitVariants(path)
    path = NormalizePortraitPath(path)
    local list = {}
    if path == "" then return list end

    local function add(p)
        if p ~= nil and p ~= "" then
            for _, v in ipairs(list) do if v == p then return end end
            table.insert(list, p)
        end
    end

    add(path)
    -- ACS/VN ของเราโหลดรูปจาก Resources/Sprs ผ่าน path แบบ Sprs/...
    add(string.gsub(path, "^Spr/", "Sprs/"))
    add(string.gsub(path, "^Sprs/", "Spr/"))

    local noext = string.gsub(path, "%.png$", "")
    if noext ~= path then
        add(noext)
        add(string.gsub(noext, "^Spr/", "Sprs/"))
        add(string.gsub(noext, "^Sprs/", "Spr/"))
    end
    return list
end

M._portraitSlots = M._portraitSlots or {}

local function VNStyleSetImage(obj, path)
    if obj == nil then return false end
    local used = false
    for _, p in ipairs(PortraitVariants(path)) do
        -- ใช้วิธีเดียวกับ VN: object ที่มี m_icon จะติดรูปบนมือถือแน่นอนกว่า GLoader/Graph
        pcall(function() obj.icon = p; used = true end)
        pcall(function() obj.url = p end)
        pcall(function()
            if obj.m_icon ~= nil then
                obj.m_icon.icon = p
                obj.m_icon.visible = true
                obj.m_icon.x = 0
                obj.m_icon.y = 0
                obj.m_icon:SetSize(obj.width, obj.height, false)
                used = true
            end
        end)
        pcall(function()
            if obj.GetChild ~= nil then
                local icon = obj:GetChild("icon")
                if icon ~= nil then
                    icon.icon = p
                    icon.visible = true
                    icon.x = 0
                    icon.y = 0
                    icon:SetSize(obj.width, obj.height, false)
                    used = true
                end
            end
        end)
        -- ไม่ลอง texture แล้ว กันหน่วง
        break
    end
    return used
end

local function NewPortraitObject(slot, baseObj)
    if M.view == nil or baseObj == nil then return nil end
    if M._portraitSlots ~= nil and M._portraitSlots[slot] ~= nil then
        return M._portraitSlots[slot]
    end

    local pkg = UIPkg()
    if pkg == nil then return nil end

    local obj = nil
    -- ใช้ object ปุ่มมาตรฐานเหมือน VN เพราะมี m_icon
    pcall(function() obj = pkg.CreateObjectFromURL("ui://0xrxw6g7hdhl18") end)
    if obj == nil then
        pcall(function() obj = pkg.CreateObjectFromURL("ui://0xrxw6g7hdhl1b") end)
    end
    if obj == nil then return nil end

    pcall(function() obj.name = "xaouPortraitSlot" .. tostring(slot) end)
    pcall(function() obj.x = baseObj.x end)
    pcall(function() obj.y = baseObj.y end)
    pcall(function() obj:SetSize(baseObj.width, baseObj.height, false) end)
    pcall(function() obj.touchable = false end)
    pcall(function() obj.title = "" end)

    -- ซ่อนพื้น/ข้อความของปุ่ม เหลือแค่ m_icon
    pcall(function()
        local n = tonumber(obj.numChildren) or 0
        for i = 0, n - 1 do
            local c = obj:GetChildAt(i)
            if c ~= nil then c.visible = false end
        end
    end)
    pcall(function() if obj.m_title ~= nil then obj.m_title.text = ""; obj.m_title.visible = false end end)
    pcall(function() if obj.m_button ~= nil then obj.m_button.visible = false end end)
    pcall(function() if obj.m_check ~= nil then obj.m_check.visible = false end end)
    pcall(function() if obj.m_checkmark ~= nil then obj.m_checkmark.visible = false end end)
    pcall(function()
        if obj.m_icon ~= nil then
            obj.m_icon.visible = true
            obj.m_icon.x = 0
            obj.m_icon.y = 0
            obj.m_icon:SetSize(obj.width, obj.height, false)
        end
    end)

    pcall(function() M.view:AddChild(obj) end)
    M._portraitSlots[slot] = obj
    return obj
end

local function SetPortrait(baseObj, portrait, slot)
    if baseObj == nil then return end
    portrait = NormalizePortraitPath(portrait)

    local overlay = NewPortraitObject(slot or 0, baseObj)

    if portrait == "" then
        -- ไม่มีรูป: ซ่อน overlay แต่คงช่องเขียวเดิมไว้เป็น placeholder
        if overlay ~= nil then SetVisible(overlay, false) end
        SetVisible(baseObj, true)
        return
    end

    if overlay ~= nil then
        SetVisible(overlay, true)
        pcall(function() overlay.x = baseObj.x end)
        pcall(function() overlay.y = baseObj.y end)
        pcall(function() overlay:SetSize(baseObj.width, baseObj.height, false) end)
        VNStyleSetImage(overlay, portrait)
        -- มีรูปแล้วซ่อนช่องเขียวพื้นหลัง
        SetVisible(baseObj, false)
    else
        -- fallback: ลองยัดลง object เดิมแบบ VN
        SetVisible(baseObj, true)
        VNStyleSetImage(baseObj, portrait)
    end
end

local function GuessPortrait(npc)
    if npc == nil then return "" end
    if npc.portrait ~= nil and tostring(npc.portrait) ~= "" then return npc.portrait end
    if npc.model ~= nil and tostring(npc.model) ~= "" then return "Spr/Npc/" .. tostring(npc.model) .. ".png" end
    if npc.modelName ~= nil and tostring(npc.modelName) ~= "" then return "Spr/Npc/" .. tostring(npc.modelName) .. ".png" end
    if npc.cn ~= nil and tostring(npc.cn) ~= "" then
        local cnMap = {
            ["紫萱"]="zx", ["唐雪见"]="xj", ["景天"]="jt", ["徐长卿"]="cq",
            ["龙葵"]="lk", ["南宫煌"]="ngh", ["星璇"]="xx", ["温慧"]="wh",
            ["王蓬絮"]="wpx", ["重楼"]="cl", ["李逍遥"]="lxy", ["赵灵儿"]="zle",
            ["林月如"]="lyr", ["阿奴"]="anu", ["司徒钟"]="jjx"
        }
        local key = cnMap[tostring(npc.cn)]
        if key ~= nil then return "Spr/Npc/" .. key .. ".png" end
    end
    return ""
end


local FindLoadedNpcById -- forward declaration for InspectNpc

-- ---------- NPC Inspect / Debug ----------
local function AppendLine(lines, key, value)
    if lines == nil then return end
    if value == nil then value = "nil" end
    table.insert(lines, tostring(key) .. ": " .. tostring(value))
end

local function SafeProp(obj, key)
    if obj == nil or key == nil then return nil end
    local ok, value = pcall(function() return obj[key] end)
    if ok then return value end
    local getter = "get_" .. tostring(key)
    ok, value = pcall(function()
        if obj[getter] ~= nil then return obj[getter](obj) end
        return nil
    end)
    if ok then return value end
    return nil
end

local function BuildNpcInspectText(npc, loadedNpc)
    local lines = {}
    AppendLine(lines, "ชื่อ", npc and npc.name)
    AppendLine(lines, "จีน", npc and npc.cn)
    AppendLine(lines, "ID", npc and npc.id)
    AppendLine(lines, "Seed", npc and npc.seed)
    AppendLine(lines, "RecruitID", npc and npc.recruitId)
    AppendLine(lines, "FakeID", npc and npc.fakeId)
    AppendLine(lines, "Source", npc and npc.source)
    AppendLine(lines, "Race", npc and npc.race)
    AppendLine(lines, "Portrait", npc and npc.portrait)
    AppendLine(lines, "GuessPortrait", GuessPortrait(npc))
    AppendLine(lines, "LoadedNpc", loadedNpc ~= nil and "พบในเกม" or "ยังไม่พบ/ยังไม่ถูกเสก")

    if loadedNpc ~= nil then
        AppendLine(lines, "Loaded tostring", tostring(loadedNpc))
        local keys = {
            "Name", "name", "ID", "Id", "id", "Seed", "seed", "RandomSeed", "randomSeed",
            "NpcID", "npcID", "Race", "race", "Sex", "sex", "Age", "age",
            "Model", "model", "ModelName", "modelName", "Prefab", "prefab", "PrefabName", "prefabName",
            "Avatar", "avatar", "Icon", "icon", "Portrait", "portrait", "Head", "head",
            "Body", "body", "BodyID", "Hair", "Clothes", "ClothesStuff"
        }
        for _, key in ipairs(keys) do
            local v = SafeProp(loadedNpc, key)
            if v ~= nil then AppendLine(lines, "NPC." .. key, v) end
        end
    end

    return table.concat(lines, "\n")
end

function M.InspectNpc(npc)
    if npc == nil then
        ShowMsg("ไม่มี NPC ให้ตรวจสอบ")
        return false
    end

    local seed = tonumber(npc.seed or npc.id) or npc.seed or npc.id
    local loadedNpc = nil
    pcall(function()
        if FindLoadedNpcById ~= nil then
            loadedNpc = FindLoadedNpcById(seed)
        end
    end)

    local text = BuildNpcInspectText(npc, loadedNpc)
    _G.Xaou_NpcSelector_LastInspect = text

    -- Popup สั้น ๆ พอ กันมือถือไม่ชอบข้อความยาว
    ShowMsg("ตรวจสอบ: " .. tostring(npc.name or npc.id or "NPC") .. "\nดูรายละเอียดในการ์ด")
    return true
end

local function EnableClick(obj)
    if obj == nil then return end
    pcall(function() obj.touchable = true end)
    pcall(function() obj.enabled = true end)
    pcall(function() obj.grayed = false end)
end

local function AddClick(obj, fn)
    if obj == nil or fn == nil then return end
    EnableClick(obj)
    -- Graph/Text ใน ACS มือถือบางครั้งรับคลิกได้ถ้า touchable=true
    -- ใช้ Clear ก่อนเพื่อกันกดซ้ำหลายรอบตอน RefreshList
    pcall(function() if obj.onClick ~= nil then obj.onClick:Clear() end end)
    pcall(function() if obj.onClick ~= nil then obj.onClick:Add(fn) end end)
    -- fallback บางเวอร์ชันใช้ AddEventListener
    pcall(function()
        if obj.AddEventListener ~= nil and CS ~= nil and CS.FairyGUI ~= nil then
            obj:AddEventListener(CS.FairyGUI.EventContext.CLICK, fn)
        end
    end)
end

local function Center(view, root)
    if view == nil or root == nil then return end
    pcall(function()
        view.x = (root.width - view.width) / 2
        view.y = (root.height - view.height) / 2
    end)
    pcall(function() view:Center() end)
end

-- ---------- Reincarnate NPC Spawn ----------
-- ใช้ ID จาก Settings/Npc/Reincarnate/reincarnate.txt ของม็อด NPC จีน
local function ToLuaInteger(value)
    if value == nil then return nil end
    if type(value) == "number" then return math.floor(value) end

    local number = nil
    pcall(function() number = tonumber(value) end)
    if number ~= nil then return math.floor(number) end

    pcall(function() number = tonumber(value.value) end)
    if number ~= nil then return math.floor(number) end

    local text = nil
    pcall(function() text = value:ToString() end)
    if text == nil or text == "" then text = tostring(value) end
    local digits = string.match(tostring(text), "%-?%d+")
    if digits ~= nil then return tonumber(digits) end
    return nil
end

local function GetSchoolCapacity()
    local school = nil
    pcall(function() school = CS.XiaWorld.SchoolMgr.Instance end)
    if school == nil then return nil, nil, nil, "SchoolMgr.Instance=nil" end

    pcall(function() school:UpdateCount() end)

    local discipleRaw = nil
    local npcCountRaw = nil
    local maximumRaw = nil
    pcall(function() discipleRaw = school.DiscipleCount end)
    pcall(function() npcCountRaw = school:GetNpcCount() end)
    pcall(function() maximumRaw = school:GetDiscipleMax() end)

    local discipleCount = ToLuaInteger(discipleRaw)
    local npcCount = ToLuaInteger(npcCountRaw)
    local current = discipleCount
    if current == nil or (npcCount ~= nil and npcCount > current) then current = npcCount end
    local maximum = ToLuaInteger(maximumRaw)

    local debugText = "DiscipleCount=" .. tostring(discipleRaw)
        .. " GetNpcCount=" .. tostring(npcCountRaw)
        .. " GetDiscipleMax=" .. tostring(maximumRaw)

    return current, maximum, school, debugText
end

local function SpawnReincarnateNpcByID(id)
    local capacityAfter = ""
    local ok, err = pcall(function()
        id = tonumber(id)
        if id == nil then error("ID ว่าง") end

        local discipleCount, discipleMax, _, capacityDebug = GetSchoolCapacity()
        if discipleCount == nil or discipleMax == nil or discipleMax <= 0 then
            error("ตรวจจำนวนศิษย์ไม่ได้\n" .. tostring(capacityDebug))
        end
        if discipleCount >= discipleMax then
            error("จำนวนศิษย์เต็มแล้ว " .. tostring(discipleCount) .. "/" .. tostring(discipleMax))
        end

        local mgr = nil
        pcall(function() mgr = CS.XiaWorld.NpcMgr.Instance end)
        if mgr == nil then error("ไม่พบ NpcMgr.Instance") end

        local LH = mgr:GetReincarnateDataByID(id)
        if LH == nil then
            error("ไม่พบ ReincarnateData ID " .. tostring(id) .. "\nตรวจว่าติดตั้ง/เปิดม็อด NPC จีนแล้วหรือยัง")
        end

        local vx = CS.UnityEngine.Vector2(0, 0)
        local race = LH.Race
        if race == nil or tostring(race) == "" then race = "Human" end

        local npc = CS.XiaWorld.NpcRandomMechine.RandomNpc(
            race, LH.Sex, 0, vx, LH.LastName, LH.FristName, true, 0, LH
        )
        if npc == nil then error("สร้าง NPC ไม่สำเร็จ") end

        local key = nil
        pcall(function() key = CS.XiaWorld.World.Instance.map:RandomBronGrid() end)
        if key == nil then pcall(function() key = Map:RandomBronGrid() end) end
        if key == nil then error("หาตำแหน่งเกิดไม่ได้") end

        local map = nil
        pcall(function() map = World.map end)
        if map == nil then pcall(function() map = CS.XiaWorld.World.Instance.map end) end
        if map == nil then error("ไม่พบ map") end

        mgr:AddNpc(npc, key, map, CS.XiaWorld.Fight.g_emFightCamp.Player)

        pcall(function()
            CS.XiaWorld.ThingMgr.Instance:EquptNpc(
                npc, 0, CS.XiaWorld.g_emNpcRichLable.Richest,
                false, true, 0, 0, false, false
            )
        end)

        pcall(function() npc:ChangeRank(CS.XiaWorld.g_emNpcRank.Worker) end)

        local currentAfter, maximumAfter, school = GetSchoolCapacity()
        if school ~= nil then
            pcall(function() school:UpdateCount() end)
        end
        if currentAfter ~= nil and maximumAfter ~= nil then
            capacityAfter = "\nจำนวนศิษย์: " .. tostring(currentAfter) .. "/" .. tostring(maximumAfter)
        end
    end)

    if ok then
        ShowMsg("เพิ่ม NPC เข้าสำนักแล้ว\nID: " .. tostring(id) .. capacityAfter)
        return true
    else
        ShowMsg("เพิ่ม NPC ไม่สำเร็จ:\n" .. tostring(err))
        return false
    end
end


local function InviteJianghuNpcBySeed(seed)
    local ok, err = pcall(function()
        seed = tonumber(seed)
        if seed == nil then error("ไม่พบ Jianghu Seed") end

        local discipleCount, discipleMax, _, capacityDebug = GetSchoolCapacity()
        if discipleCount == nil or discipleMax == nil or discipleMax <= 0 then
            error("ตรวจจำนวนศิษย์ไม่ได้\n" .. tostring(capacityDebug))
        end
        if discipleCount >= discipleMax then
            error("จำนวนศิษย์เต็มแล้ว " .. tostring(discipleCount) .. "/" .. tostring(discipleMax))
        end

        local school = CS.XiaWorld.SchoolGlobleMgr.Instance
        local eventMgr = CS.XiaWorld.GameEventMgr.Instance
        local world = CS.XiaWorld.World.Instance
        if school == nil or eventMgr == nil or world == nil then
            error("ระบบยุทธภพยังไม่พร้อม")
        end
        if school:IsJianghuNpcDie(seed) then error("NPC คนนี้เสียชีวิตแล้ว") end
        if school:IsJianghuNpcLeave(seed) then error("NPC คนนี้กำลังเดินทางอยู่") end

        local save = CS.XiaWorld.GameEventMgr.EventSaveData()
        save.param1 = seed
        local eventData = eventMgr:AddEvent(102, world.TolSecond + 1200, save)
        if eventData == nil then error("สร้างกิจกรรมเชิญ NPC ไม่สำเร็จ") end
        school:AddJianghuNpcLeave(seed)
    end)

    if ok then
        ShowMsg("ส่งคำเชิญแล้ว\nNPC จะเดินทางมาเยี่ยมสำนักในอีกไม่นาน")
        return true
    end
    ShowMsg("ชวน NPC สำนักอื่นไม่สำเร็จ:\n" .. tostring(err))
    return false
end

local function GetText(obj)
    if obj == nil then return "" end
    local v = ""
    pcall(function() if obj.text ~= nil then v = obj.text end end)
    pcall(function() if (v == nil or v == "") and obj.title ~= nil then v = obj.title end end)
    return tostring(v or "")
end

local function ContainsText(value, key)
    if key == nil or key == "" then return true end
    value = tostring(value or "")
    key = tostring(key or "")
    return string.find(string.lower(value), string.lower(key), 1, true) ~= nil
end

local function ReadCsMember(obj, name, fallback)
    if obj == nil then return fallback end
    local ok, value = pcall(function() return obj[name] end)
    if ok and value ~= nil then return value end
    return fallback
end

local function ReadCsListItem(list, index)
    if list == nil then return nil end

    local ok, value = pcall(function() return list:get_Item(index) end)
    if ok then return value end

    ok, value = pcall(function() return list[index] end)
    if ok then return value end
    return nil
end

local function NumberValue(value, fallback)
    local ok, n = pcall(function() return tonumber(value) end)
    if not ok then n = nil end
    if n ~= nil then return n end
    ok, n = pcall(function() return tonumber(tostring(value or "")) end)
    if not ok then n = nil end
    if n ~= nil then return n end
    return fallback
end

local function SexLabel(value)
    local n = NumberValue(value, 0)
    if n == 1 then return "Male" end
    if n == 2 then return "Female" end
    return tostring(value or "Unknown")
end

local function AddDictionaryKeys(dict, output, seen)
    if dict == nil then return end

    local function add(value)
        local seed = NumberValue(value, nil)
        if seed ~= nil and not seen[tostring(seed)] then
            seen[tostring(seed)] = true
            table.insert(output, seed)
        end
    end

    pcall(function()
        local e = dict:GetEnumerator()
        while e:MoveNext() do add(e.Current.Key) end
    end)

    pcall(function()
        local e = dict.Keys:GetEnumerator()
        while e:MoveNext() do add(e.Current) end
    end)
end

local function GetJianghuManager()
    local mgr = nil
    pcall(function() mgr = JianghuMgr end)
    if mgr == nil then pcall(function() mgr = CS.XiaWorld.JianghuMgr.Instance end) end
    return mgr
end

local function GetJianghuDef(mgr, seed)
    local def = nil
    pcall(function() def = mgr:GetJHNpcDataByRandomSeed(seed) end)
    if def == nil then pcall(function() def = mgr:GetJHNpcDataBySeed(seed) end) end
    return def
end

local function GetJianghuName(mgr, def, seed)
    local name = ""
    pcall(function() name = tostring(mgr:GetJHNpcName(seed, true, false) or "") end)
    if name == "" and def ~= nil then
        local last = tostring(ReadCsMember(def, "LastName", "") or "")
        local first = tostring(ReadCsMember(def, "FristName", "") or "")
        if first == "" then first = tostring(ReadCsMember(def, "FirstName", "") or "") end
        name = last .. first
    end
    if name == "" then name = "Jianghu NPC " .. tostring(seed) end
    return name
end

local function IsJianghuNpcAvailable(school, seed)
    local dead = false
    local left = false
    pcall(function() dead = school:IsJianghuNpcDie(seed) == true end)
    pcall(function() left = school:IsJianghuNpcLeave(seed) == true end)
    return not dead and not left
end

function M.AutoDiscoverNpcData()
    local merged = {}
    local known = {}

    for _, npc in ipairs(M._builtinData or {}) do
        table.insert(merged, npc)
        known[tostring(npc.id)] = true
    end

    M.autoDiscoveredCount = 0
    M.modDiscoveredCount = 0
    M.jianghuDiscoveredCount = 0
    M.autoDiscoveryError = nil

    local ok, err = pcall(function()
        local mgr = CS.XiaWorld.NpcMgr.Instance
        if mgr == nil then error("NpcMgr.Instance is nil") end

        local ids = mgr:GetReincarnateIDs(false)
        if ids == nil then error("GetReincarnateIDs returned nil") end

        local count = NumberValue(ReadCsMember(ids, "Count", 0), 0)
        local discovered = {}

        for i = 0, count - 1 do
            local rawId = ReadCsListItem(ids, i)
            local id = NumberValue(rawId, nil)

            if id ~= nil and id > 0 and not known[tostring(id)] then
                local def = mgr:GetReincarnateDataByID(id)
                if def ~= nil then
                    local hidden = NumberValue(ReadCsMember(def, "IsHide", 0), 0)
                    local isCreat = NumberValue(ReadCsMember(def, "IsCreat", 0), 0)
                    local modelPath = tostring(ReadCsMember(def, "Mod", "") or "")
                    local portrait = tostring(ReadCsMember(def, "FixedLooks", "") or "")

                    -- IsCreat is not a mod marker. The game also sets it for global
                    -- reincarnation records created from dead characters in other
                    -- saves. External mods commonly use a high ID even when they use
                    -- vanilla looks, while built-in reincarnates use low IDs.
                    local hasCustomAssets = modelPath ~= "" or portrait ~= ""
                    local isExternalDefinition = isCreat ~= 1
                    local looksLikeModCharacter = hasCustomAssets or isExternalDefinition

                    if hidden < 2 and looksLikeModCharacter then
                        local last = tostring(ReadCsMember(def, "LastName", "") or "")
                        local first = tostring(ReadCsMember(def, "FristName", "") or "")
                        local name = last .. first
                        if name == "" then name = "NPC " .. tostring(id) end

                        local desc = tostring(ReadCsMember(def, "Desc", "") or "")
                        local race = tostring(ReadCsMember(def, "Race", "Human") or "Human")
                        if race == "" then race = "Human" end

                        table.insert(discovered, {
                            id = id,
                            seed = NumberValue(ReadCsMember(def, "Seed", id), id),
                            fakeId = id,
                            recruitId = id,
                            name = name,
                            last = last,
                            first = first,
                            sex = NumberValue(ReadCsMember(def, "Sex", 0), 0),
                            sexText = SexLabel(ReadCsMember(def, "Sex", 0)),
                            age = tostring(ReadCsMember(def, "Age", "-")),
                            sect = "NPC จากม็อดอื่น",
                            source = "auto_reincarnate",
                            cn = "",
                            desc = desc ~= "" and desc or ("Loaded Reincarnate ID " .. tostring(id)),
                            portrait = portrait,
                            model = modelPath,
                            race = race
                        })
                        known[tostring(id)] = true
                    end
                end
            end
        end

        table.sort(discovered, function(a, b)
            local an = tostring(a.name or "")
            local bn = tostring(b.name or "")
            if an == bn then return NumberValue(a.id, 0) < NumberValue(b.id, 0) end
            return an < bn
        end)

        for _, npc in ipairs(discovered) do table.insert(merged, npc) end
        M.modDiscoveredCount = #discovered

        local jmgr = GetJianghuManager()
        local school = CS.XiaWorld.SchoolGlobleMgr.Instance
        if jmgr ~= nil and school ~= nil then
            local seeds = {}
            local seedSeen = {}
            AddDictionaryKeys(ReadCsMember(school, "JianghuNpcs", nil), seeds, seedSeen)
            AddDictionaryKeys(ReadCsMember(jmgr, "KnowNpcData", nil), seeds, seedSeen)

            local jianghu = {}
            for _, seed in ipairs(seeds) do
                if IsJianghuNpcAvailable(school, seed) then
                    local def = GetJianghuDef(jmgr, seed)
                    if def ~= nil then
                        local name = GetJianghuName(jmgr, def, seed)
                        local desc = tostring(ReadCsMember(def, "Desc", "") or "")
                        local portrait = tostring(ReadCsMember(def, "FixedLooks", "") or "")
                        if portrait == "" then portrait = tostring(ReadCsMember(def, "RolePaint", "") or "") end
                        local model = tostring(ReadCsMember(def, "Mod", "") or "")

                        table.insert(jianghu, {
                            id = seed,
                            seed = seed,
                            fakeId = seed,
                            recruitId = nil,
                            name = name,
                            sex = NumberValue(ReadCsMember(def, "Sex", 0), 0),
                            sexText = SexLabel(ReadCsMember(def, "Sex", 0)),
                            age = tostring(ReadCsMember(def, "Age", "-")),
                            sect = "NPC สำนักอื่นบนแผนที่โลก",
                            source = "jianghu_world",
                            cn = "",
                            desc = desc ~= "" and desc or "ตัวละครยุทธภพจากสำนักอื่น",
                            portrait = portrait,
                            model = model,
                            race = tostring(ReadCsMember(def, "Race", "Human") or "Human")
                        })
                    end
                end
            end

            table.sort(jianghu, function(a, b)
                local an = tostring(a.name or "")
                local bn = tostring(b.name or "")
                if an == bn then return NumberValue(a.seed, 0) < NumberValue(b.seed, 0) end
                return an < bn
            end)

            for _, npc in ipairs(jianghu) do table.insert(merged, npc) end
            M.jianghuDiscoveredCount = #jianghu
        end

        M.autoDiscoveredCount = M.modDiscoveredCount + M.jianghuDiscoveredCount
    end)

    if not ok then M.autoDiscoveryError = tostring(err) end
    M.data = merged
    M.filteredData = nil
    return ok, M.autoDiscoveredCount, M.autoDiscoveryError
end

local function DataList()
    

-- Portrait stub (temporary)
function M.UpdateNpcPortrait(card,npc)
    return
end
return M.filteredData or M.data
end

function M.ApplySearch(keyword)
    keyword = tostring(keyword or "")
    M.searchKeyword = keyword

    if keyword == "" then
        M.filteredData = nil
    else
        local list = {}
        for _, npc in ipairs(M.data) do
            local text = tostring(npc.name or "") .. " " .. tostring(npc.cn or "") .. " " .. tostring(npc.sect or "") .. " " .. tostring(npc.desc or "") .. " " .. tostring(npc.id or "")
            if ContainsText(text, keyword) then
                table.insert(list, npc)
            end
        end
        M.filteredData = list
    end

    M.page = 1
    M.selectedIndex = 1
    M.RefreshList()
end

local function MaxPage()
    return math.max(1, math.ceil(#DataList() / M.pageSize))
end

local function CurrentNpc()
    return DataList()[M.selectedIndex]
end

FindLoadedNpcById = function(id)
    -- ตัวนี้เป็นตัวช่วยแบบปลอดภัย เผื่อ Core ต้องการ npc object จริงภายหลัง
    -- ถ้าเกม/ม็อดหลักไม่มี API ให้หา จะคืน nil แต่ยังส่ง id กลับได้
    local npc = nil

    pcall(function()
        if JianghuMgr ~= nil and JianghuMgr.GetKnowNpcData ~= nil then
            npc = JianghuMgr:GetKnowNpcData(id)
        end
    end)

    pcall(function()
        if npc == nil and JianghuMgr ~= nil and JianghuMgr.GetJHNpcDataBySeed ~= nil then
            npc = JianghuMgr:GetJHNpcDataBySeed(id)
        end
    end)

    pcall(function()
        if npc == nil and JianghuMgr ~= nil and JianghuMgr.GetJHNpcDataByRandomSeed ~= nil then
            npc = JianghuMgr:GetJHNpcDataByRandomSeed(id)
        end
    end)

    return npc
end

-- ---------- UI Refresh ----------
-- เวอร์ชันนี้ทำให้ตรงกับ FGUIProject ล่าสุดแบบไม่ต้องแก้ FGUI ก่อน
-- สาเหตุเดิม: ชิ้นส่วนหลายตัวอยู่ระดับเดียวกับหน้าต่าง และการ์ดกลางตั้งชื่อซ้ำเป็น Info_panel2
-- วิธีแก้: การ์ดซ้าย/ขวาใช้ชื่อจริง, การ์ดกลางใช้ index ตามลำดับใน displayList

local function GetChildAt(parent, index)
    if parent == nil or index == nil then return nil end
    local ok, obj = pcall(function() return parent:GetChildAt(index) end)
    if ok then return obj end
    return nil
end

local function GetObj(ref)
    if M.view == nil or ref == nil then return nil end
    if type(ref) == "number" then return GetChildAt(M.view, ref) end
    return GetChild(M.view, ref)
end

-- index เป็น 0-based ตาม FairyGUI GetChildAt
-- card1 = ซ้าย, card2 = กลาง, card3 = ขวา
local cardMap = {
    {
        panel="Info_panel3", portrait="imgPortrait1", name="txtName1", idText="ID1", sect="txtSect1",
        age="txtAge1", gender="txtGender1", status="txtStatus1", favor="txtFavor1", power="txtPower1", desc="txtDesc1",
        recruit="btnRecruit1", openheart="btnOpenHeart1",
    },
    {
        panel="Info_panel2", portrait="imgPortrait2", name="txtName2", idText="ID2", sect="txtSect2",
        age="txtAge2", gender="txtGender2", status="txtStatus2", favor="txtFavor2", power="txtPower2", desc="txtDesc2",
        recruit="btnRecruit2", openheart="btnOpenHeart2",
    },
    {
        panel="Info_panel1", portrait="imgPortrait3", name="txtName3", idText="ID3", sect="txtSect3",
        age="txtAge3", gender="txtGender3", status="txtStatus3", favor="txtFavor3", power="txtPower3", desc="txtDesc3",
        recruit="btnRecruit3", openheart="btnOpenHeart3",
    },
}

local function SetObjText(ref, text)
    SetText(GetObj(ref), text)
end

local function SetCardVisible(map, value)
    if map == nil then return end
    for _, key in ipairs({"panel","portrait","name","idText","sect","age","gender","status","favor","power","desc","recruit","openheart"}) do
        if map[key] ~= nil then SetVisible(GetObj(map[key]), value) end
    end
    if map.extra ~= nil then
        for _, ref in ipairs(map.extra) do SetVisible(GetObj(ref), value) end
    end
end

local function FillCard(slot, npc, dataIndex)
    local map = cardMap[slot]
    if map == nil then return end

    if npc == nil then
        SetCardVisible(map, false)
        return
    end

    SetCardVisible(map, true)
    SetPortrait(GetObj(map.portrait), GuessPortrait(npc), slot)

    -- เปลี่ยนปุ่มเปิดใจเป็นปุ่มตรวจสอบข้อมูลชั่วคราว
    pcall(function() GetObj(map.recruit).title = "ชวนเข้าสำนัก" end)
    pcall(function() GetObj(map.openheart).title = "ตรวจสอบ" end)
    if map.extra ~= nil then
        SetText(GetObj(map.extra[1]), "ชวนเข้าสำนัก")
        SetText(GetObj(map.extra[2]), "ตรวจสอบ")
    end

    local mark = ""
    if dataIndex == M.selectedIndex then mark = "▶ " end

    SetObjText(map.name, mark .. tostring(npc.name or "-"))
    SetObjText(map.idText, "ID: " .. tostring(npc.id or npc.seed or "-"))
    SetObjText(map.sect, "สำนัก: " .. tostring(npc.sect or "-"))
    SetObjText(map.age, "อายุ: " .. tostring(npc.age or "-"))
    SetObjText(map.gender, "เพศ: " .. tostring(npc.sexText or "-"))
    SetObjText(map.status, "สถานะ: พร้อมเลือก")
    SetObjText(map.power, "พลังฝีมือ: -")
    SetObjText(map.favor, "ความสัมพันธ์: -")

    local desc = "seed: " .. tostring(npc.seed or npc.id or "-") ..
        "\nID เดิม: " .. tostring(npc.fakeId or npc.id or "-") ..
        "\n" .. tostring(npc.desc or "")
    SetObjText(map.desc, desc)

    local function selectThis()
        M.selectedIndex = dataIndex
        M.RefreshList()
    end

    AddClick(GetObj(map.panel), selectThis)
    AddClick(GetObj(map.name), selectThis)
    AddClick(GetObj(map.desc), selectThis)

    -- ปุ่มจริงกับข้อความบนปุ่มอาจเป็นคนละ object กัน
    -- ถ้าข้อความวางทับปุ่ม ให้ผูก onClick ให้ทั้งสองชั้น
    local function recruitThis()
        M.selectedIndex = dataIndex
        M.SendToCore("recruit")
        M.RefreshList()
    end

    local function inspectThis()
        M.selectedIndex = dataIndex
        local ok, err = pcall(function()
            M.InspectNpc(npc)
        end)
        if not ok then
            _G.Xaou_NpcSelector_LastInspect = "Inspect Error: " .. tostring(err)
            ShowMsg("ตรวจสอบผิดพลาด")
        end

        -- แสดงผลตรวจสอบลงในช่องรายละเอียดของการ์ดทันที
        -- ไม่ RefreshList ทับ เพราะจะทำให้ข้อมูล debug หาย
        if _G.Xaou_NpcSelector_LastInspect ~= nil then
            SetObjText(map.desc, tostring(_G.Xaou_NpcSelector_LastInspect))
        end
    end

    AddClick(GetObj(map.recruit), recruitThis)
    AddClick(GetObj(map.openheart), inspectThis)

    if map.extra ~= nil then
        AddClick(GetObj(map.extra[1]), recruitThis)
        AddClick(GetObj(map.extra[2]), inspectThis)
    end
end

function M.RefreshInfo()
    -- UI แบบ 3 การ์ดไม่มีแผงรายละเอียดแยกแล้ว ใช้ RefreshList เติมข้อมูลในการ์ดโดยตรง
end

function M.RefreshList()
    local view = M.view
    if view == nil then return end

    local list = DataList()
    M.pageSize = 3

    local maxPage = MaxPage()
    if M.page > maxPage then M.page = maxPage end
    if M.page < 1 then M.page = 1 end

    local startIndex = (M.page - 1) * M.pageSize + 1

    for i = 1, M.pageSize do
        local idx = startIndex + i - 1
        FillCard(i, list[idx], idx)
    end

    SetText(GetChild(view, "txtPage"), tostring(M.page) .. "/" .. tostring(MaxPage()))
    SetText(GetChild(view, "txtCount"), "พบทั้งหมด: " .. tostring(#DataList()) .. " คน")
end

local function DirectOpenHeart(seed, addFavor)
    seed = tonumber(seed) or seed
    local ok, err = pcall(function()
        if seed == nil then error("seed ว่าง") end

        if Xaou_OpenHeartBySeed ~= nil then
            Xaou_OpenHeartBySeed(seed, addFavor == true)
            return
        end

        local data = nil
        pcall(function()
            if JianghuMgr ~= nil and JianghuMgr.GetKnowNpcData ~= nil then
                data = JianghuMgr:GetKnowNpcData(seed)
            end
        end)

        if data == nil then
            pcall(function()
                if JianghuMgr ~= nil and JianghuMgr.UnLockJiangHuNpc ~= nil then
                    JianghuMgr:UnLockJiangHuNpc(seed)
                end
            end)
            pcall(function()
                if JianghuMgr ~= nil and JianghuMgr.UnLockNpcDataKnow ~= nil then
                    JianghuMgr:UnLockNpcDataKnow(seed)
                end
            end)
            pcall(function()
                if JianghuMgr ~= nil and JianghuMgr.GetKnowNpcData ~= nil then
                    data = JianghuMgr:GetKnowNpcData(seed)
                end
            end)
            pcall(function()
                if data == nil and JianghuMgr ~= nil and JianghuMgr.GetJHNpcDataByRandomSeed ~= nil then
                    data = JianghuMgr:GetJHNpcDataByRandomSeed(seed)
                end
            end)
            pcall(function()
                if data == nil and JianghuMgr ~= nil and JianghuMgr.GetJHNpcDataBySeed ~= nil then
                    data = JianghuMgr:GetJHNpcDataBySeed(seed)
                end
            end)
        end

        if data == nil then error("หา Jianghu NPC ไม่เจอ อาจยังไม่ได้เปิดม็อด NPC จีน") end

        pcall(function() data.Vigilance = 0 end)
        pcall(function() data.hlock = 1 end)
        if addFavor == true then
            pcall(function() data.favour = 100 end)
            pcall(function() data.Favour = 100 end)
            pcall(function() data.Favor = 100 end)
        end
    end)

    if not ok then
        ShowMsg("เปิดใจไม่สำเร็จ: " .. tostring(err))
        return false
    end
    return true
end

local function SendCoreHook(npc, action, loadedNpc)
    local seed = tonumber(npc.seed or npc.id) or npc.seed or npc.id
    local called = false

    local function try(fn)
        if type(fn) == "function" then
            called = true
            pcall(function() fn(seed, npc, action, loadedNpc) end)
        end
    end

    if Xaou009_ACS_Mod ~= nil then
        try(Xaou009_ACS_Mod.OnExternalNpcSelected)
        if action == "recruit" then try(Xaou009_ACS_Mod.RecruitExternalNpc) end
        if action == "openheart" then try(Xaou009_ACS_Mod.OpenHeartExternalNpc) end
    end

    if action == "recruit" then try(_G.Xaou_RecruitExternalNpc) end
    if action == "openheart" then try(_G.Xaou_OpenHeartExternalNpc) end

    return called
end


local function SendCallback(npc, action, ok)
    if type(M.onSelectCallback) == "function" then
        pcall(function() M.onSelectCallback(npc, action, ok) end)
    end
end

-- ---------- Actions ----------
function M.SendToCore(action)
    local npc = CurrentNpc()

    if npc == nil then
        ShowMsg("ยังไม่ได้เลือก NPC")
        return false
    end

    local seed = tonumber(npc.seed or npc.id) or npc.seed or npc.id
    _G.Xaou_SelectedExternalNpc = npc
    _G.Xaou_SelectedExternalNpcID = seed

    local loadedNpc = FindLoadedNpcById(seed)

    if action == "openheart" then
        -- ตอนนี้ใช้ปุ่มเปิดใจเป็นโหมดตรวจสอบข้อมูลก่อน
        local ok = M.InspectNpc(npc)
        SendCallback(npc, "inspect", ok)
        return ok
    end

    if action == "recruit" then
        if npc.source == "jianghu_world" then
            local ok = InviteJianghuNpcBySeed(seed)
            SendCoreHook(npc, action, loadedNpc)
            SendCallback(npc, action, ok)
            return ok
        end

        -- ม็อดแยกตัวนี้เสก NPC เข้าสำนักเอง โดยใช้ Reincarnate ID ของแถวที่เลือก
        -- ไม่ส่งไปยุ่งกับระบบเก่าของม็อดหลัก
        local recruitId = tonumber(npc.recruitId or npc.reincarnateId or npc.fakeId or npc.id)
        if recruitId ~= nil then
            local ok = SpawnReincarnateNpcByID(recruitId)
            SendCoreHook(npc, action, loadedNpc)
            SendCallback(npc, action, ok)
            return ok
        end
        ShowMsg("ไม่มี ID สำหรับเสก NPC: " .. tostring(npc.name))
        return false
    end

    SendCoreHook(npc, action, loadedNpc)
    SendCallback(npc, action, true)
    ShowMsg("เลือก NPC: " .. npc.name .. " (" .. tostring(action) .. ")")
    return true
end

function M.BindButtons()
    local view = M.view
    if view == nil then return end

    AddClick(GetChild(view, "btnClose"), function()
        M.Close()
    end)

    SetText(GetChild(view, "btnClose"), "×")
    SetText(GetChild(view, "btnSearch"), "ค้นหา")
    SetText(GetChild(view, "btnClear"), "ล้าง")
    SetText(GetChild(view, "btnPrev"), "◀ ก่อนหน้า")
    SetText(GetChild(view, "btnNext"), "ถัดไป ▶")
    SetText(GetChild(view, "btnRefresh"), "รีเฟรชรายชื่อ")

    AddClick(GetChild(view, "btnCancel"), function()
        M.Close()
    end)

    AddClick(GetChild(view, "btnRecruit"), function()
        M.SendToCore("recruit")
    end)


    AddClick(GetChild(view, "btnSelect"), function()
        M.SendToCore("select")
    end)

    AddClick(GetChild(view, "btnSearch"), function()
        M.ApplySearch(GetText(GetChild(view, "inputSearch")))
    end)

    AddClick(GetChild(view, "btnClear"), function()
        local input = GetChild(view, "inputSearch")
        SetText(input, "")
        M.ApplySearch("")
    end)

    AddClick(GetChild(view, "btnOpenHeart"), function()
        M.SendToCore("openheart")
    end)
    SetText(GetChild(view, "btnOpenHeart"), "ตรวจสอบ")
    pcall(function() if GetChild(view, "btnOpenHeart") ~= nil then GetChild(view, "btnOpenHeart").title = "ตรวจสอบ" end end)

    AddClick(GetChild(view, "btnRefresh"), function()
        local ok, count, err = M.AutoDiscoverNpcData()
        M.RefreshList()
        if ok then
            ShowMsg("รีเฟรชรายชื่อ NPC แล้ว"
                .. "\nNPC จากม็อดอื่น: " .. tostring(M.modDiscoveredCount or 0)
                .. "\nNPC สำนักอื่นบนแผนที่โลก: " .. tostring(M.jianghuDiscoveredCount or 0)
                .. "\nรวมที่ค้นพบอัตโนมัติ: " .. tostring(count))
        else
            ShowMsg("รีเฟรชรายชื่อ NPC แล้ว\nสแกนอัตโนมัติไม่สำเร็จ: " .. tostring(err))
        end
    end)

    local nextFn = function()
        M.page = math.min(MaxPage(), M.page + 1)
        M.RefreshList()
    end
    AddClick(GetChild(view, "btnNext"), nextFn)
    AddClick(GetChild(view, "btnNextpage"), nextFn)

    local prevFn = function()
        M.page = math.max(1, M.page - 1)
        M.RefreshList()
    end
    AddClick(GetChild(view, "btnPrev"), prevFn)
    AddClick(GetChild(view, "btnPrevPage"), prevFn)
end

-- ---------- Public API ----------

function M.IsOpen()
    return M.view ~= nil
end

function M.Toggle(callback)
    if M.IsOpen() then
        M.Close()
        return false
    end
    return M.Open(callback)
end

function M.GetSelected()
    return CurrentNpc()
end

function M.SetData(list)
    if type(list) == "table" then
        M.data = list
        M.filteredData = nil
        M.page = 1
        M.selectedIndex = 1
        if M.view ~= nil then M.RefreshList() end
    end
end

function M.AddNpc(npc)
    if type(npc) == "table" then
        table.insert(M.data, npc)
        if M.view ~= nil then M.RefreshList() end
    end
end

function M.Close()
    if M.view ~= nil then
        pcall(function() M.view:RemoveFromParent() end)
        pcall(function() M.view:Dispose() end)
        M.view = nil
    end

    -- สำคัญ: overlay รูปถูก Dispose ไปพร้อมหน้าต่างแล้ว
    -- ถ้าไม่ล้าง cache เปิดรอบใหม่ Lua จะคิดว่า object รูปยังมีอยู่
    -- แล้วจะไม่สร้างรูปใหม่ ทำให้เปิดครั้งถัดไปรูปหาย
    M._portraitSlots = {}
end

function M.Open(callback)
    M.Close()
    M._portraitSlots = {}

    M.onSelectCallback = callback
    M.page = 1
    M.selectedIndex = 1
    M.filteredData = nil
    M.searchKeyword = ""

    local pkg = UIPkg()
    local root = Root()

    if pkg == nil or root == nil then
        ShowMsg("ไม่พบ FairyGUI / GRoot")
        return false
    end

    local okPkg = pcall(function()
        pkg.AddPackage(M.packagePath)
    end)

    if not okPkg then
        ShowMsg("โหลด UI ไม่ได้: " .. M.packagePath)
        return false
    end

    local view = nil
    pcall(function()
        view = pkg.CreateObject(M.packageName, M.componentName)
        if view ~= nil and view.asCom ~= nil then view = view.asCom end
    end)

    if view == nil then
        ShowMsg("เปิด UI ไม่ได้: " .. M.packageName .. "/" .. M.componentName)
        return false
    end

    M.view = view
    root:AddChild(view)
    Center(view, root)

    M.BindButtons()
    M.AutoDiscoverNpcData()
    M.RefreshList()

    ShowMsg("เปิด NPC Selector แล้ว")
    return true
end

-- ชื่อสำรอง เผื่อ Core เรียกแบบฟังก์ชันเดี่ยว
function Xaou_OpenNpcSelector(callback)
    return M.Open(callback)
end

function Xaou_OpenExternalNpcSelector(callback)
    return M.Open(callback)
end

function Xaou_ToggleNpcSelector(callback)
    return M.Toggle(callback)
end

function M.OpenFromNpc(npc, callback)
    M.originNpc = npc
    return M.Open(callback)
end

function Xaou_OpenNpcSelectorFromNpc(npc, callback)
    return M.OpenFromNpc(npc, callback)
end

local SelectorNpcButtonMod = nil
pcall(function() SelectorNpcButtonMod = GameMain:GetMod("Xaou_NpcSelector") end)

local function AddSelectorButtonToNpc(npc)
    if npc == nil then return end

    local isNpc = false
    pcall(function() isNpc = npc.ThingType == g_emThingType.Npc end)
    if not isNpc then return end

    pcall(function() npc:RemoveBtnData("ดึงคนเข้าสำนัก") end)
    pcall(function()
        npc:AddBtnData(
            "ดึงคนเข้าสำนัก",
            "res/Sprs/ui/icon_hand",
            "Xaou_OpenNpcSelectorFromNpc(bind)",
            "เปิดรายชื่อ NPC จากม็อดอื่นและสำนักอื่นบนแผนที่โลก",
            nil
        )
    end)
end


-- Public bridge for Xaou Mod Center or another compatible mod.
function Xaou_NpcSelector_AddButton(npc)
    AddSelectorButtonToNpc(npc)
end

if SelectorNpcButtonMod ~= nil then
    function SelectorNpcButtonMod:OnEnter()
        local events = GameMain:GetMod("_Event")
        if events == nil then return end

        pcall(function()
            events:UnRegisterEvent(g_emEvent.SelectNpc, "XaouNpcSelector_SelectNpc")
        end)
        events:RegisterEvent(g_emEvent.SelectNpc, function(_, npc)
            AddSelectorButtonToNpc(npc)
        end, "XaouNpcSelector_SelectNpc")
    end

    function SelectorNpcButtonMod:OnLeave()
        local events = GameMain:GetMod("_Event", true)
        if events ~= nil then
            pcall(function()
                events:UnRegisterEvent(g_emEvent.SelectNpc, "XaouNpcSelector_SelectNpc")
            end)
        end
        M.Close()
    end
end

_G.Xaou_NpcSelector_Loaded = true
