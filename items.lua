return {
    PlaceObj('ModItemCode', {
        'name', "BuildingTemplate",
        'FileName', "Code/BuildingTemplate.lua",
    }),
    PlaceObj('ModItemCode', {
        'name', "Code",
        'FileName', "Code/Code.lua",
    }),
    PlaceObj('ModItemCode', {
        'name', "FundedCasino",
        'FileName', "Code/FundedCasino.lua",
    }),
    PlaceObj('ModItemOptionChoice', {
        'name', "Gamblers",
        'DisplayName', "Gamblers",
        'Help', "Who can gamble at the casino?",
        'DefaultValue', "Everyone",
        'ChoiceList', {
            "Everyone",
            "Tourists",
            "Colonists",
            "Humans",
            "Martians",
        },
    }),
    PlaceObj('ModItemOptionToggle', {
        'name', "LockCCs",
        'DisplayName', "Lock Casino Complexes",
        'Help', "Lock Casino Complexes in the build menu",
    }),
    PlaceObj('ModItemOptionToggle', {
        'name', "HideCCs",
        'DisplayName', "Hide Casino Complexes",
        'Help', "Hide Casino Complexes in the build menu",
    }),
}
