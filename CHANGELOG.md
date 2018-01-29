## 0.2.0 (2018-01-29)

Features:

 - Enabled trim mode for ERB templates using a hyphen (e.g. `<%- code -%>` will remove preceeding indentation and a
   following newline).
 - Example directory giving real usage examples in terraform.

## 0.1.0 (2018-01-28)

Features:

 - Initial version, reads json from stdin, takes path to ERB template as first argument, outputs json object with
	rendered template as the value to key "rendered".
