;extends

(block_mapping_pair
  key: (flow_node) @_run
  (#any-of? @_run "lambda")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "cpp")))

