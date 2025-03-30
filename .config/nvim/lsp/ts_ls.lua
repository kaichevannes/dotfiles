require 'lspconfig'.ts_ls.setup {
  init_options = {
    plugins = {
      {
        name = "@styled/typescript-styled-plugin",
        location = "/usr/local/lib/node_modules/@styled/typescript-styled-plugin",
        tags = { "styled", "css", "sty" }
      },
    },
  },
}
