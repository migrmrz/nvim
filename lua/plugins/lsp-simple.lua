-- Simple LSP setup that avoids mason-lspconfig compatibility issues
return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({})
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Global diagnostic keymaps
      vim.keymap.set('n', '<leader>vd', '<cmd>lua vim.diagnostic.open_float()<cr>')
      vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
      vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

      -- LSP keymaps (set when LSP attaches to buffer)
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = {buffer = event.buf}

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', '<leader>vrr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', '<leader>vws', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', opts)
          vim.keymap.set('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({'n', 'x'}, '<leader>vf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
          vim.keymap.set('n', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        end
      })

      -- Get capabilities from nvim-cmp
      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Native LSP config API (nvim-lspconfig's require('lspconfig').X.setup()
      -- framework is deprecated as of Neovim 0.11; nvim-lspconfig now ships
      -- default configs under its lsp/ directory that vim.lsp.config extends).
      vim.lsp.config('*', {
        capabilities = lsp_capabilities,
      })

      -- Lua Language Server with Neovim configuration
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = {'vim'},
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              }
            }
          }
        }
      })

      -- Go Language Server (if available)
      -- GOTMPDIR is set globally in init.lua, so gopls will inherit it
      vim.lsp.config('gopls', {
        settings = {
          gopls = {
            -- Minimal configuration to avoid blocking issues
            -- Disable problematic features that cause "no package metadata" errors
            hints = {
              assignVariableTypes = false,
              compositeLiteralFields = false,
              compositeLiteralTypes = false,
              constantValues = false,
              functionTypeParameters = false,
              parameterNames = false,
              rangeVariableTypes = false,
            },
            -- Basic analyses only
            analyses = {
              unusedparams = false,
            },
            staticcheck = false,
            -- Disable features that might cause blocking
            completeUnimported = false,
            usePlaceholders = false,
            expandWorkspaceToModule = true,
          },
        },
        -- Prevent blocking by ensuring single_file_support
        single_file_support = true,
      })

      -- HTML, JSON, Python, YAML Language Servers (if available) use
      -- nvim-lspconfig's shipped defaults as-is; no per-server overrides needed.

      vim.lsp.enable({ 'lua_ls', 'gopls', 'html', 'jsonls', 'pyright', 'yamlls' })
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        sources = cmp.config.sources({
          {name = 'nvim_lsp'},
          {name = 'luasnip'},
        }),
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-y>'] = cmp.mapping.confirm({select = true}),
          ['<C-Space>'] = cmp.mapping.complete(),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })
    end
  }
} 
