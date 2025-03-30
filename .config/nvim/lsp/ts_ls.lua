return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  init_options = {
    hostInfo = "neovim",
    plugins = {
      {
        name = "@styled/typescript-styled-plugin",
        location = "/usr/local/lib/node_modules/@styled/typescript-styled-plugin",
        tags = { "styled", "css", "sty" }
      },
    },
  },
}
