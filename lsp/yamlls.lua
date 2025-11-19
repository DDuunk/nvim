-- Find more schemas here: https://www.schemastore.org/json/
local schemas = {
  ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = { "docker-compose.yaml", "docker-compose.yml" },
  ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
    ".gitlab-ci.yml",
    "ci/*.yml",
    "ci/*.yaml",
    "ci/**/*.yml",
    "ci/**/*.yaml",
    "/*gitlab-ci*.yml",
    "**/*gitlab-ci*.yml",
  },
  ["https://raw.githubusercontent.com/lalcebo/json-schema/master/serverless/reference.json"] = { "serverless.yaml", "serverless.yml" },
}

return {
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  settings = {
    yaml = {
      schemas = schemas,
      validate = true,
      hover = true,
      completion = true,
      customtags = {
        "!Ref",
        "!GetAtt",
        "!Sub",
      },
    },
  },
}
