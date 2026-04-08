#Requires AutoHotkey v2.0

; ============================================
; Layout Switch — F8
; מתקן טקסט שהוקלד בשפה הלא נכונה
; סמן טקסט → לחץ F8 → מתוקן
; ============================================

; מיפוי מקלדת אנגלית → עברית (Standard Israeli layout)
enToHe := Map(
    "q","/"  , "w","'"  , "e","ק"  , "r","ר"  , "t","א"  , "y","ט"  , "u","ו"  , "i","ן"  , "o","ם"  , "p","פ",
    "a","ש"  , "s","ד"  , "d","ג"  , "f","כ"  , "g","ע"  , "h","י"  , "j","ח"  , "k","ל"  , "l","ך"  , ";","ף",
    "z","ז"  , "x","ס"  , "c","ב"  , "v","ה"  , "b","נ"  , "n","מ"  , "m","צ",
    ",","ת"  , ".","ץ"  , "/",".",
    "Q","/"  , "W","'"  , "E","ק"  , "R","ר"  , "T","א"  , "Y","ט"  , "U","ו"  , "I","ן"  , "O","ם"  , "P","פ",
    "A","ש"  , "S","ד"  , "D","ג"  , "F","כ"  , "G","ע"  , "H","י"  , "J","ח"  , "K","ל"  , "L","ך",
    "Z","ז"  , "X","ס"  , "C","ב"  , "V","ה"  , "B","נ"  , "N","מ"  , "M","צ"
)

; מיפוי עברית → אנגלית
heToEn := Map(
    "/","q"  , "'","w"  , "ק","e"  , "ר","r"  , "א","t"  , "ט","y"  , "ו","u"  , "ן","i"  , "ם","o"  , "פ","p",
    "ש","a"  , "ד","s"  , "ג","d"  , "כ","f"  , "ע","g"  , "י","h"  , "ח","j"  , "ל","k"  , "ך","l"  , "ף",";",
    "ז","z"  , "ס","x"  , "ב","c"  , "ה","v"  , "נ","b"  , "מ","n"  , "צ","m",
    "ת",","  , "ץ","."  , ".","/"
)

; F8 = המרה (עדיפות גבוהה — דורס כל תוכנה כולל VS Code)
#InputLevel 1
$F8:: {
    ; שמור clipboard
    clipSave := ClipboardAll()
    A_Clipboard := ""

    ; העתק מסומן — 3 ניסיונות עם ClipWait
    Send("^c")
    if ClipWait(2) {
        ; הצלחה
    } else {
        ; ניסיון שני
        Sleep(200)
        Send("^c")
        if ClipWait(2) {
            ; הצלחה
        } else {
            MsgBox("לא נבחר טקסט! סמן טקסט לפני לחיצה.")
            A_Clipboard := clipSave
            return
        }
    }

    text := A_Clipboard
    result := ""

    ; זהה אם עברי או אנגלי
    isHebrew := false
    loop parse, text {
        if (Ord(A_LoopField) >= 0x0590 && Ord(A_LoopField) <= 0x05FF) {
            isHebrew := true
            break
        }
    }

    ; המר כל תו
    useMap := isHebrew ? heToEn : enToHe
    loop parse, text {
        if useMap.Has(A_LoopField)
            result .= useMap[A_LoopField]
        else
            result .= A_LoopField
    }

    ; הדבק
    A_Clipboard := result
    Sleep(100)
    Send("^v")

    ; שחזר clipboard
    Sleep(200)
    A_Clipboard := clipSave
}
