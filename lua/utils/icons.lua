local icons = {}

icons.debugging_signs = {
	Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
	Breakpoint = " ",
	BreakpointCondition = " ",
	BreakpointRejected = { " ", "DiagnosticError" },
	LogPoint = ".>",
}

icons.diagnostic_signs = {
	error = " ",
	warn = " ",
	hint = " ",
	info = "",
}

return icons

