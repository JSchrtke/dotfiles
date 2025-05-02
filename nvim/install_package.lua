-- https://stackoverflow.com/a/27028488
local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local function make_package_dir()
    -- TODO avoid hardcoding the path, use the env
    local path = "/home/js/.config/nvim/pack"
    if vim.system({"stat", path}):wait().code == 0 then
        local ret = vim.system({"mkdir", path}):wait()
        if ret ~= 0 then
            return "Failed to create package directory: " .. dump(ret)
        end
    end
    return nil
end

local function print_error(message)
    local chunks = {{message}}
    local opts = {err = true}
    vim.api.nvim_echo(chunks, false, opts)
end

local function install()
    local error = make_package_dir()
    if error ~= nil then
        print_error(error)
        return
    end
end

install()
