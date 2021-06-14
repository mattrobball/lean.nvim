describe('filetype detection', function()
  require('tests.helpers').setup {}

  it('recognizes a lean 3 file',
    function(_)
      vim.api.nvim_command("edit lua/tests/fixtures/example-lean3-project/test.lean")
      assert.is.same(vim.bo.ft, "lean3")
    end)
end)