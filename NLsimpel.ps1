# Zet alle systeem instellingen op Nederlands #

$Lang  = 'nl-NL'
$TZ    = 'W. Europe Standard Time'
$GeoId = 176              # NL

# 1. taalpakket – overslaan als al aanwezig
#   dism /online /add-capability /CapabilityName:Language.Basic~~~$Lang~0.0.1.0 /NoRestart

# 2. cultuur & home-location
Set-Culture             $Lang
Set-WinSystemLocale     $Lang
Set-WinHomeLocation     -GeoId $GeoId
Set-TimeZone            -Id   $TZ

# 3. keyboard (US-INT of NL)
$ll = New-WinUserLanguageList $Lang
$ll[0].InputMethodTips.Clear()
$ll[0].InputMethodTips.Add('00020409')   # of '00000413'
Set-WinUserLanguageList $ll -Force

# 4. alles kopiëren naar systeem + nieuwe users
Copy-UserInternationalSettingsToSystem -WelcomeScreen $true -NewUser $true

#Restart-Computer -Force
