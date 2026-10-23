-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local lt = Instance.new("LocalizationTable")
lt.SourceLocaleId = "en-us"

lt:SetEntries({
    {
        Key = "greet_named",
        Source = "Hello {user}",
        Context = "",
        Example = "",
        Values = {
            ["en-us"] = "Hi {user}!",
            ["es-es"] = "Hola {user}!",
        },
    },
    {
        Key = "score_num",
        Source = "{1} pts / {2}",
        Context = "",
        Example = "",
        Values = {
            ["en-us"] = "{2}: {1}",
        },
    },
})

local trEn = lt:GetTranslator("en-us")
local trEs = lt:GetTranslator("es-es")

local function drop(c)
    lt:Destroy()
    fail(c)
end

if typeof(trEn) ~= "Instance" or not trEn:IsA("Translator") then
    drop(1)
end

if trEn:FormatByKey("greet_named", { user = "pengu" }) ~= "Hi pengu!" then
    drop(2)
end

if trEs:FormatByKey("greet_named", { user = "pengu" }) ~= "Hola pengu!" then
    drop(3)
end

if trEn:FormatByKey("score_num", { 77, "SL" }) ~= "SL: 77" then
    drop(4)
end

if pcall(trEn.FormatByKey, trEn, "missing_key_sl") then
    drop(5)
end

if pcall(trEn.FormatByKey, trEn, "greet_named", {}) then
    drop(6)
end

lt:RemoveEntryValue("greet_named", "Hello {user}", "", "ES-ES")
if pcall(trEs.FormatByKey, trEs, "greet_named", { user = "pengu" }) then
    local fallback = trEs:FormatByKey("greet_named", { user = "pengu" })
    if fallback == "Hola pengu!" then
        drop(7)
    end
end

lt:Destroy()
print("ud")
