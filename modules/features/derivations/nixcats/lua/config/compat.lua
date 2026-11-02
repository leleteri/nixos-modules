-- Thin wrapper over the nixCats API so the same Lua also loads (without
-- plugins) on a machine that has plain Neovim and no Nix.
local M = {}

M.is_nix = pcall(require, "nixCats")

--- Is a category enabled? Always true outside Nix.
function M.cat(name)
  if not M.is_nix then
    return true
  end
  return nixCats(name) and true or false
end

--- Read a value from the package's `extra` table, with a fallback.
function M.extra(path, default)
  if M.is_nix then
    local v = nixCats.extra(path)
    if v ~= nil then
      return v
    end
  end
  return default
end

--- require(mod) and call .setup(opts) if it exists; warn instead of erroring.
function M.setup(mod, opts)
  local ok, m = pcall(require, mod)
  if not ok then
    vim.notify(("plugin not available: %s"):format(mod), vim.log.levels.WARN)
    return nil
  end
  if type(m) == "table" and type(m.setup) == "function" then
    m.setup(opts or {})
  end
  return m
end

return M
