; (variable_declarator
;   (comment) @gql_comment
;   (#eq? @gql_comment "/* GraphQL */")
;   (template_string) @graphql)

(call_expression
  function: (identifier) @func_name
  arguments: (arguments
    (template_string) @graphql
    (#match? @func_name "^gql$")
  )
  (#match? @graphql "^`"))
