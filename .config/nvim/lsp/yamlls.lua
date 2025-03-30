-- Extra options available for validation with schemas
return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  root_markers = { ".git" },
  settings = {
    redhat = {
      telemetry = {
        enabled = false
      }
    }
  }
}
