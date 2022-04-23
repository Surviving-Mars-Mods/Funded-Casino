--see Info/LICENSE for license and copyright info
local function Log(...)
    FF.Funcs.LogMessage(CurrentModDef.title, "BuildingTemplate", ...)
end

function OnMsg.ClassesPostprocess()
    Log("Adding Funded Casino Building Template")

    if not BuildingTemplates.FFFundedCasino then
        PlaceObj('BuildingTemplate', {
            'Group', "Dome Services",
            'Id', "FFFundedCasino",
            'template_class', "FundedCasino",
            'construction_cost_Concrete', 20000,
            'construction_cost_Electronics', 15000,
            'build_points', 18000,
            'is_tall', true,
            'dome_required', true,
            'upgrade1_id', "Casino_ServiceBots",
            'upgrade1_display_name', T(5020, --[[BuildingTemplate CasinoComplex upgrade1_display_name]] "Service Bots"),
            'upgrade1_description', T(5021, --[[BuildingTemplate CasinoComplex upgrade1_description]] "This building no longer requires Workers and operates at <upgrade1_add_value_2> Performance."),
            'upgrade1_icon', "UI/Icons/Upgrades/service_bots_01.tga",
            'upgrade1_mod_prop_id_1', "automation",
            'upgrade1_add_value_1', 1,
            'upgrade1_mod_prop_id_2', "auto_performance",
            'upgrade1_add_value_2', 100,
            'upgrade1_mod_prop_id_3', "max_workers",
            'upgrade1_mul_value_3', -100,
            'upgrade1_upgrade_cost_Electronics', 10000,
            'maintenance_resource_type', "Electronics",
            'maintenance_resource_amount', 2000,
            'display_name', "Funded Casino",
            'display_name_pl', "Funded Casinos",
            'description', "A place of luxurious entertainment and questionable morals, helping to bring out the best of humanity... and make a lot of money!",
            'build_category', "Dome Services",
            'display_icon', "UI/Icons/Buildings/casino_complex.tga",
            'build_pos', 7,
            'entity', "Casino",
            'encyclopedia_id', "CasinoComplex",
            'encyclopedia_image', "UI/Encyclopedia/CasinoComplex.tga",
            'label1', "InsideBuildings",
            'palette_color1', "inside_accent_2",
            'palette_color2', "inside_base",
            'palette_color3', "inside_accent_service",
            'demolish_sinking', range(5, 10),
            'demolish_tilt_angle', range(600, 900),
            'demolish_debris', 85,
            'disabled_in_environment1', "",
            'entity2', "PyramidCasinoCCP2",
            'entitydlc2', "ariane",
            'palette2_color1', "inside_base",
            'palette2_color2', "inside_accent_2",
            'electricity_consumption', 5000,
            'service_comfort', 70000,
            'comfort_increase', 15000,
            'interest1', "interestLuxury",
            'interest2', "interestGaming",
            'interest3', "interestGambling",
            'interest4', "interestSocial",
            'max_visitors', 10,
            'enabled_shift_3', false,
            'max_workers', 3,
        })
    end
end