
local SCRIPT_OWNER = "{{ user_id }}"
local REVIEW_URL = "https://www.gmodstore.com/market/view/pixel-karts#add-review"

local function getReviewState(callback)
    callback = callback or function() end

    http.Fetch("https://api.tomdotbat.dev/pixel-karts/reviewers.php", function(body, _, _, statusCode)
        local reviewers = util.JSONToTable(body)
        if not reviewers then return end
        if reviewers.message then return end

        for i = 1, #reviewers do
            if reviewers[i] == SCRIPT_OWNER then
                return callback(true)
            end
        end

        callback(false)
    end, nil, {
        ["Licensee"] = "{{ user_id }}",
        ["ServerAddress"] = game.GetIPAddress(),
        ["Hostname"] = GetHostName(),
        ["Challenge"] = "{{ user_id | 80 }}"
    })
end

local function addReviewCommand()
    hook.Add("OnPlayerChat", "PIXEL.Karts.ReviewCommand", function(ply, text)
        if ply ~= LocalPlayer() then return end

        if string.Trim(string.lower(text)) == "!pixelkarts_review" then
            gui.OpenURL(REVIEW_URL)
            return true
        end
    end)
end

local function removeReviewCommand()
    hook.Remove("OnPlayerChat", "PIXEL.Karts.ReviewCommand")
end

local function isReadyForReview()
    local joinCount = cookie.GetNumber("PIXEL.Karts.ReviewJoinCount", 0)
    cookie.Set("PIXEL.Karts.ReviewJoinCount", joinCount + 1)
    return joinCount >= 5
end

hook.Add("SetupMove", "PIXEL.Karts.CheckForAddonOwner", function(ply, mv, cmd)
    if cmd:IsForced() or mv:GetForwardSpeed() == 0 then return end
    if ply ~= LocalPlayer() then return end

    hook.Remove("SetupMove", "PIXEL.Karts.CheckForAddonOwner")
    if ply:SteamID64() ~= SCRIPT_OWNER then getReviewState() return end
    if not isReadyForReview() then return end

    getReviewState(function(hasReviewed)
        if hasReviewed then return end

        addReviewCommand()

        timer.Create("PIXEL.Karts.CheckForReview", 30, 0, function()
            getReviewState(function(hasReviewedNow)
                if not hasReviewedNow then return end
                chat.AddText(PIXEL.Colors.PrimaryText, "Thank you for leaving a review on PIXEL Karts!", PIXEL.Colors.Negative, " ❤")
                chat.PlaySound()
                removeReviewCommand()
                timer.Remove("PIXEL.Karts.CheckForReview")
            end)
        end)

        chat.AddText(PIXEL.Colors.PrimaryText, "Thank you for purchasing PIXEL Karts. If you're happy with the addon why not leave a review?")
        chat.AddText(PIXEL.Colors.PrimaryText, "Go to ", PIXEL.Colors.Primary, REVIEW_URL, PIXEL.Colors.PrimaryText, " or type", PIXEL.Colors.Negative, " !pixelkarts_review", PIXEL.Colors.PrimaryText, ".")
        chat.PlaySound()
    end)
end)