local helpers = require('tests.helpers')
local fixtures = require('tests.fixtures')

require('lean').setup { lsp3 = { enable = true } }

helpers.if_has_lean3('lean.current_search_paths', function()
  for kind, path in unpack(fixtures.lean3_project.files_it) do
    it(string.format('returns the paths for %s lean 3 files', kind), function()
      vim.api.nvim_command('edit ' .. path)
      helpers.wait_for_ready_lsp()

      local paths = require('lean').current_search_paths()
      assert.are_equal(3, #paths)
      -- via its leanpkg.path:
      assert.has_all(
        table.concat(paths, '\n') .. '\n',
        {
          '/lib/lean/library\n',                     -- Lean 3 standard library
          fixtures.lean3_project.path .. '/src\n',   -- the project itself
          fixtures.lean3_project.path .. '/_target/deps/mathlib/src\n'    -- the project itself
        }
      )
    end)
  end
end)