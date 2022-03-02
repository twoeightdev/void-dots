local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_next_item(),
        ["<C-j>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm { select = true },

        -- Tab mapping
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "path" },
        { name = "luasnip" },
    },
    documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
}

-- With path cmp only
-- cmp.setup {
--     mapping = {
--         ["<C-n>"] = cmp.mapping.select_next_item(),
--         ["<C-p>"] = cmp.mapping.select_prev_item(),
--         ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--         ["<C-f>"] = cmp.mapping.scroll_docs(4),
--         ["<C-Space>"] = cmp.mapping.complete(),
--         ["<C-e>"] = cmp.mapping.close(),
--         ["<CR>"] = cmp.mapping.confirm { select = true },
--
--         -- Tab mapping
--         ["<Tab>"] = function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif has_words_before() then
--                 cmp.complete()
--             else fallback()
--             end
--         end,
--         ['<S-Tab>'] = function(fallback)
--             if cmp.visible() then
--                 cmp.select_prev_item()
--             else fallback()
--             end
--         end,
--     },
--     sources = {
--         { name = "path" },
--     },
-- }
