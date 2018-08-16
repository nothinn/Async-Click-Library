# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PHASE_INIT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VALUE" -parent ${Page_0}


}

proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to update DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to validate DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.PHASE_INIT { PARAM_VALUE.PHASE_INIT } {
	# Procedure called to update PHASE_INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PHASE_INIT { PARAM_VALUE.PHASE_INIT } {
	# Procedure called to validate PHASE_INIT
	return true
}

proc update_PARAM_VALUE.VALUE { PARAM_VALUE.VALUE } {
	# Procedure called to update VALUE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VALUE { PARAM_VALUE.VALUE } {
	# Procedure called to validate VALUE
	return true
}


proc update_MODELPARAM_VALUE.PHASE_INIT { MODELPARAM_VALUE.PHASE_INIT PARAM_VALUE.PHASE_INIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PHASE_INIT}] ${MODELPARAM_VALUE.PHASE_INIT}
}

proc update_MODELPARAM_VALUE.DATA_WIDTH { MODELPARAM_VALUE.DATA_WIDTH PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH}] ${MODELPARAM_VALUE.DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.VALUE { MODELPARAM_VALUE.VALUE PARAM_VALUE.VALUE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VALUE}] ${MODELPARAM_VALUE.VALUE}
}

