--see license.md for license/copyright info
local function Log(...)
  FF.LogMessage(CurrentModDef.title, "FundedCasino", ...)
end

DefineClass.FundedCasino = {
  -- __parents = "CasinoComplex"  -- causes engine fault
  __parents = { "ElectricityConsumer", "ServiceWorkplace" },
  ProfitDay = 0,
  ProfitLife = 0,
}

-- Play a game of roulette!
function FundedCasino:PlayRoulette(unit)
  local Odds = 4637
  local Payout
  local PayoutMod = 1
  local Bet = SessionRandom:Random(47500, 52500)
  local Result = SessionRandom:Random(10000)

  -- for the big gamblers
  if unit.traits.Gambler then
    Odds = 1053
    PayoutMod = 8
  end

  -- for the tourists
  if unit.traits.Tourist then
    Bet = Bet * 5
  end

  -- crafty sob trying to make a quick buck
  if unit.traits.Genius then
    Odds = Odds * 2.5
  end

  -- calculate potential payout
  Payout = Bet * PayoutMod * -1

  --fail out if we can't cover the payout
  if UIColony.funds:GetFunding() < (Payout * -1) then
    return false
  end

  Log("Result, Odds, Bet, Payout, PayoutMod = ", Result, ", ", Odds, ", " , Bet, ", ", Payout, ", ", PayoutMod, ", ")

  --win or lose, change funding and add to log
  if Result <= Odds then
    Log("Loss: ", Payout)
    return Payout
  else
    Log("Win: ", Bet)
    return Bet
  end

  return true
end

function FundedCasino:Service(unit, duration)
  local Gamble = false

  --check if this colonist can gamble
  local Gamblers = CurrentModOptions:GetProperty("Gamblers")
  if Gamblers == "Everyone" then
    Gamble = true
  elseif Gamblers == "Tourists" and unit.traits.Tourist then
    Gamble = true
  elseif Gamblers == "Colonists" and not unit.traits.Tourists then
    Gamble = true
  elseif Gamblers == "Humans" and unit.birthplace ~= "Mars" then
    Gamble = true
  elseif Gamblers == "Martians" and unit.birthplace == "Mars" then
    Gamble = true
  end

  --If allowed by mod option, do gambling
  if Gamble then

    --If we can't cover the payout they take sanity damage and the casino suspends operation
    local Amount = self:PlayRoulette(unit)

    if Amount == -1 then
      if unit.traits.Gambler then
        unit:ChangeSanity(-25 * const.Scale.Stat, "Casino ran out of funding! ")
      else
        unit:ChangeSanity(-10 * const.Scale.Stat, "Casino ran out of funding! ")
      end
      self:SetSuspended(true, "Out of funding")
    else
      UIColony.funds:ChangeFunding(Amount, "Casino")
      self.ProfitDay = self.ProfitDay + Amount
      self.ProfitLife = self.ProfitLife + Amount
    end
  end

  ServiceWorkplace.Service(self, unit, duration)
end