-- Defaults for the daily metric capture template: the calories of the
-- meals captured under today's date tree node in meals.org.
local M = {}

---@param path string
---@return string[]|nil
local function read_lines(path)
  local fd = io.open(path, "r")
  if not fd then
    return nil
  end
  local lines = {}
  for line in fd:lines() do
    lines[#lines + 1] = line
  end
  fd:close()
  return lines
end

--- Calories of a "Calories: N" line or a :CALORIES: property line.
---@param line string
---@return integer|nil
local function calorie_of(line)
  local s = line:lower()
  local n = s:match "^%s*:calories:%s*(%d[%d,%.]*)" or s:match "^%s*calories:%s*(%d[%d,%.]*)"
  return n and (tonumber((n:gsub(",", ""))) or 0) or nil
end

--- Total calories logged under the date tree node for `day` ("YYYY-MM-DD").
--- Uses the "Day total" entry when the day has one, else sums the meals.
---@param day? string defaults to today
---@param path? string defaults to ~/org/meals.org
---@return integer total
function M.calories_for(day, path)
  day = day or os.date "%Y-%m-%d"
  path = vim.fn.expand(path or "~/org/meals.org")
  local lines = read_lines(path)
  if not lines then
    return 0
  end
  local day_level, day_total, total = nil, nil, 0
  local entry_level, entry_title, entry_cal
  local function flush()
    if entry_level and entry_cal then
      if entry_title:lower():match "^day%s+total" then
        day_total = entry_cal
      else
        total = total + entry_cal
      end
    end
    entry_level, entry_title, entry_cal = nil, nil, nil
  end
  for _, line in ipairs(lines) do
    local stars = line:match "^(%*+)%s+"
    if stars then
      local lvl = #stars
      if day_level and lvl <= day_level then
        flush()
        break
      end
      local date = line:match "^%*+%s+(%d%d%d%d%-%d%d%-%d%d)"
      if date == day then
        flush()
        day_level = lvl
      elseif day_level and lvl == day_level + 1 then
        flush()
        entry_level = lvl
        entry_title = line:match "^%*+%s+(.-)%s*$" or ""
      end
    elseif day_level then
      local c = calorie_of(line)
      if c then
        if entry_level then
          entry_cal = c
        else
          total = total + c
        end
      end
    end
  end
  flush()
  return day_total or total
end

return M
