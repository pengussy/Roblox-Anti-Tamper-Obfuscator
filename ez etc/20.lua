local ok = pcall(function()
    game.Workspace.Part()
end)

if ok then
    print("ud")
else
    error()
end