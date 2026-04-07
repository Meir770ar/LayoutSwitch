-- LayoutSwitch for macOS (Hammerspoon)
-- Fix text typed in the wrong keyboard layout
-- Select text → press F8 → fixed!
-- Hebrew ↔ English

-- Keyboard mapping: English (US) → Hebrew (Standard Israeli)
local enToHe = {
    q="/", w="'", e="ק", r="ר", t="א", y="ט", u="ו", i="ן", o="ם", p="פ",
    a="ש", s="ד", d="ג", f="כ", g="ע", h="י", j="ח", k="ל", l="ך", [";"]="ף",
    z="ז", x="ס", c="ב", v="ה", b="נ", n="מ", m="צ",
    [","]="ת", ["."]="ץ", ["/"]=".",
    Q="/", W="'", E="ק", R="ר", T="א", Y="ט", U="ו", I="ן", O="ם", P="פ",
    A="ש", S="ד", D="ג", F="כ", G="ע", H="י", J="ח", K="ל", L="ך",
    Z="ז", X="ס", C="ב", V="ה", B="נ", N="מ", M="צ"
}

-- Keyboard mapping: Hebrew → English
local heToEn = {
    ["/"]="q", ["'"]="w", ["ק"]="e", ["ר"]="r", ["א"]="t", ["ט"]="y", ["ו"]="u", ["ן"]="i", ["ם"]="o", ["פ"]="p",
    ["ש"]="a", ["ד"]="s", ["ג"]="d", ["כ"]="f", ["ע"]="g", ["י"]="h", ["ח"]="j", ["ל"]="k", ["ך"]="l", ["ף"]=";",
    ["ז"]="z", ["ס"]="x", ["ב"]="c", ["ה"]="v", ["נ"]="b", ["מ"]="n", ["צ"]="m",
    ["ת"]=",", ["ץ"]=".", ["."]="/"
}

-- Check if text contains Hebrew characters
local function isHebrew(text)
    for i = 1, utf8.len(text) or 0 do
        local code = utf8.codepoint(text, utf8.offset(text, i))
        if code >= 0x0590 and code <= 0x05FF then
            return true
        end
    end
    return false
end

-- Convert text using the appropriate map
local function convertText(text)
    local map = isHebrew(text) and heToEn or enToHe
    local result = {}

    for i = 1, utf8.len(text) or 0 do
        local offset = utf8.offset(text, i)
        local char = text:sub(offset, utf8.offset(text, i + 1) and utf8.offset(text, i + 1) - 1 or #text)
        if map[char] then
            table.insert(result, map[char])
        else
            table.insert(result, char)
        end
    end

    return table.concat(result)
end

-- F8 hotkey: convert selected text
hs.hotkey.bind({}, "F8", function()
    -- Save clipboard
    local oldClipboard = hs.pasteboard.getContents()

    -- Copy selected text
    hs.eventtap.keyStroke({"cmd"}, "c")
    hs.timer.usleep(300000) -- 300ms

    local text = hs.pasteboard.getContents()

    if not text or text == oldClipboard then
        hs.alert.show("סמן טקסט לפני לחיצה")
        return
    end

    -- Convert
    local converted = convertText(text)

    -- Paste
    hs.pasteboard.setContents(converted)
    hs.eventtap.keyStroke({"cmd"}, "v")

    -- Restore clipboard
    hs.timer.doAfter(0.3, function()
        hs.pasteboard.setContents(oldClipboard or "")
    end)
end)

hs.alert.show("LayoutSwitch loaded — F8 to fix text")
