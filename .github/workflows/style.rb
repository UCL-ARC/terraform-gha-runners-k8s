all

# Don't enforce line length in code blocks
rule 'MD013', :ignore_code_blocks => true, :tables => false

# Don't force ordered lists with 1. 1. 1.
rule 'MD029', :style => :ordered

# Allow inline HTML
exclude_rule 'MD033'
