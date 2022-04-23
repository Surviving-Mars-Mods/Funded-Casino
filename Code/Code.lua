--see license.md for license/copyright info
local function Log(...)
    FF.LogMessage(CurrentModDef.title, "FundedCasino", ...)
end

FF.Lib.Debug = true
Log("Loading...")

local function UpdateOptions()
end

-- Get profits for this casino
function GetCasinoProfitDay(self)
    return self.ProfitDay
end

function GetCasinoProfitLife(self)
    return self.ProfitLife
end

--setup infopanel to show profit in casinos
local function SetupIP()
    --add profit info to UI for casinos
    XTemplate = XTemplates.ipBuilding[1][1]

    --add the section if it is missing
    if not table.find(XTemplate, "Id", "sectionCasinoProfit") then
        if #XTemplate < 2 then
            Log("ERROR", "Building InfoPanel template is not valid")
            return
        end

        table.insert(XTemplate, 2, PlaceObj("XTemplateTemplate", {
            "__template", "sectionCasinoProfit",
            "Id", "sectionCasinoProfit"
        }))
    end

    --no dups
    if XTemplates.sectionCasinoProfit then
        return
    end

    --add the info
    PlaceObj("XTemplate", {
        group = "Infopanel Sections",
        id = "sectionCasinoProfit",
        PlaceObj("XTemplateGroup", {
            "__context_of_kind", "FundedCasino",
        },{
            PlaceObj("XTemplateTemplate", {
                "__template", "InfopanelSection",
                "Icon", "UI/Icons/Sections/Funding.dds",
                "RolloverText", FF.Translate('Profit earned by this casino'),
                "Title", FF.Translate('Profit'),
            },{
                PlaceObj("XTemplateTemplate", {
                    "__template", "InfopanelText",
                    "Text", T{"<str>: $<profit>",
                              str = FF.Translate("Today's Profit"), profit = GetCasinoProfitDay, -- can't call a function with arguments here
                    },
                }),
                PlaceObj("XTemplateTemplate", {
                    "__template", "InfopanelText",
                    "Text", T{"<str>: $<profit>",
                              str = FF.Translate('Lifetime Profit'), profit = GetCasinoProfitLife, -- can't call a function with arguments here
                    },
                })
            })
        })
    })
end

--event handlers
OnMsg.ModsReloaded = UpdateOptions

--reset daily profit
function OnMsg.NewDay()
    if UICity then
        if UICity.labels.FundedCasino then
            for i=1, #UICity.labels.FundedCasino do
                UICity.labels.FundedCasino[i].ProfitDay = 0
            end
        end
    end
end

--resume casino operations when above 10M funding
function OnMsg.FundingChanged(...)
    if UICity then
        if UICity.labels.FundedCasino and UIColony.funds:GetFunding() >= 10000000 then
            for i=1, #UICity.labels.FundedCasino do
                if UICity.labels.FundedCasino[i].suspended then
                    UICity.labels.FundedCasino[i]:SetSuspended(false)
                end
            end
        end
    end
end

function OnMsg.ApplyModOptions(id)
    if id == CurrentModId then
        UpdateOptions()
    end
end


local function Init()
    Log("INIT")
    SetupIP()
    Log("INIT DONE")
end

OnMsg.ClassesPostprocess = Init

Log("Load Complete!")