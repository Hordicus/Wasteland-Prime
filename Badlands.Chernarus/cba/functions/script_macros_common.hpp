#ifndef MAINPREFIX
	#define MAINPREFIX x
#endif
#ifndef SUBPREFIX
	#define SUBPREFIX addons
#endif
#ifndef MAINLOGIC
	#define MAINLOGIC main
#endif
#ifndef VERSION
	#define VERSION 0
#endif
#ifndef VERSION_AR
	#define VERSION_AR VERSION
#endif
#ifndef VERSION_CONFIG
	#define VERSION_CONFIG version = VERSION; versionStr = QUOTE(VERSION); versionAr[] = {VERSION_AR}
#endif
#define ADDON DOUBLES(PREFIX,COMPONENT)
#define MAIN_ADDON DOUBLES(PREFIX,main)
#ifdef DEBUG_MODE_FULL
#define DEBUG_MODE_NORMAL
#endif
#ifdef DEBUG_MODE_NORMAL
#define DEBUG_MODE_MINIMAL
#endif
#ifndef DEBUG_MODE_MINIMAL
#define DEBUG_MODE_NORMAL
#define DEBUG_MODE_MINIMAL
#endif
#ifdef THIS_FILE
#define THIS_FILE_ 'THIS_FILE'
#else
#define THIS_FILE_ __FILE__
#endif
#ifdef DEBUG_MODE_FULL
#define LOG(MESSAGE) [THIS_FILE_, __LINE__, MESSAGE] call CBA_fnc_log
#else
#define LOG(MESSAGE) 
#endif
#ifdef DEBUG_MODE_NORMAL
#define WARNING(MESSAGE) [THIS_FILE_, __LINE__, ('WARNING: ' + MESSAGE)] call CBA_fnc_log
#else
#define WARNING(MESSAGE) 
#endif
#define ERROR(MESSAGE) \
	[THIS_FILE_, __LINE__, "ERROR", MESSAGE] call CBA_fnc_error;
#define ERROR_WITH_TITLE(TITLE,MESSAGE) \
	[THIS_FILE_, __LINE__, TITLE, MESSAGE] call CBA_fnc_error;
#define RETNIL(VARIABLE) if (isNil{VARIABLE}) then {nil} else {VARIABLE}
#define PFORMAT_1(MESSAGE,A) \
	format ['%1: A=%2', MESSAGE, RETNIL(A)]
#define PFORMAT_2(MESSAGE,A,B) \
	format ['%1: A=%2, B=%3', MESSAGE, RETNIL(A), RETNIL(B)]
#define PFORMAT_3(MESSAGE,A,B,C) \
	format ['%1: A=%2, B=%3, C=%4', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C)]
#define PFORMAT_4(MESSAGE,A,B,C,D) \
	format ['%1: A=%2, B=%3, C=%4, D=%5', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D)]
#define PFORMAT_5(MESSAGE,A,B,C,D,E) \
	format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E)]
#define PFORMAT_6(MESSAGE,A,B,C,D,E,F) \
	format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E), RETNIL(F)]
#define PFORMAT_7(MESSAGE,A,B,C,D,E,F,G) \
	format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E), RETNIL(F), RETNIL(G)]
#define PFORMAT_8(MESSAGE,A,B,C,D,E,F,G,H) \
	format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8, H=%9', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E), RETNIL(F), RETNIL(G), RETNIL(H)]
#define PFORMAT_9(MESSAGE,A,B,C,D,E,F,G,H,I) \
	format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8, H=%9, I=%10', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E), RETNIL(F), RETNIL(G), RETNIL(H), RETNIL(I)]
#ifdef DEBUG_MODE_FULL
#define TRACE_1(MESSAGE,A) \
	[THIS_FILE_, __LINE__, PFORMAT_1(MESSAGE,A)] call CBA_fnc_log
#define TRACE_2(MESSAGE,A,B) \
	[THIS_FILE_, __LINE__, PFORMAT_2(MESSAGE,A,B)] call CBA_fnc_log
#define TRACE_3(MESSAGE,A,B,C) \
	[THIS_FILE_, __LINE__, PFORMAT_3(MESSAGE,A,B,C)] call CBA_fnc_log
#define TRACE_4(MESSAGE,A,B,C,D) \
	[THIS_FILE_, __LINE__, PFORMAT_4(MESSAGE,A,B,C,D)] call CBA_fnc_log
#define TRACE_5(MESSAGE,A,B,C,D,E) \
	[THIS_FILE_, __LINE__, PFORMAT_5(MESSAGE,A,B,C,D,E)] call CBA_fnc_log
#define TRACE_6(MESSAGE,A,B,C,D,E,F) \
	[THIS_FILE_, __LINE__, PFORMAT_6(MESSAGE,A,B,C,D,E,F)] call CBA_fnc_log
#define TRACE_7(MESSAGE,A,B,C,D,E,F,G) \
	[THIS_FILE_, __LINE__, PFORMAT_7(MESSAGE,A,B,C,D,E,F,G)] call CBA_fnc_log
#define TRACE_8(MESSAGE,A,B,C,D,E,F,G,H) \
	[THIS_FILE_, __LINE__, PFORMAT_8(MESSAGE,A,B,C,D,E,F,G,H)] call CBA_fnc_log
#define TRACE_9(MESSAGE,A,B,C,D,E,F,G,H,I) \
	[THIS_FILE_, __LINE__, PFORMAT_9(MESSAGE,A,B,C,D,E,F,G,H,I)] call CBA_fnc_log
#else
#define TRACE_1(MESSAGE,A) 
#define TRACE_2(MESSAGE,A,B) 
#define TRACE_3(MESSAGE,A,B,C) 
#define TRACE_4(MESSAGE,A,B,C,D) 
#define TRACE_5(MESSAGE,A,B,C,D,E) 
#define TRACE_6(MESSAGE,A,B,C,D,E,F) 
#define TRACE_7(MESSAGE,A,B,C,D,E,F,G) 
#define TRACE_8(MESSAGE,A,B,C,D,E,F,G,H) 
#define TRACE_9(MESSAGE,A,B,C,D,E,F,G,H,I) 
#endif
#define DOUBLES(var1,var2) ##var1##_##var2
#define TRIPLES(var1,var2,var3) ##var1##_##var2##_##var3
#define QUOTE(var1) #var1
#ifdef MODULAR
	#define COMPONENT_T DOUBLES(t,COMPONENT)
	#define COMPONENT_M DOUBLES(m,COMPONENT)
	#define COMPONENT_S DOUBLES(s,COMPONENT)
	#define COMPONENT_C DOUBLES(c,COMPONENT)
	#define COMPONENT_F COMPONENT_C
#else
	#define COMPONENT_T COMPONENT
	#define COMPONENT_M COMPONENT
	#define COMPONENT_S COMPONENT
	#define COMPONENT_F COMPONENT
	#define COMPONENT_C COMPONENT
#endif
#define INC(var) var = (var) + 1
#define DEC(var) var = (var) - 1
#define ADD(var1,var2) var1 = (var1) + (var2)
#define SUB(var1,var2) var1 = (var1) - (var2)
#define REM(var1,var2) SUB(var1,[var2])
#define PUSH(var1,var2) var1 set [count (var1), var2]
#define ISNILS(VARIABLE,DEFAULT_VALUE) if (isNil #VARIABLE) then { ##VARIABLE = ##DEFAULT_VALUE }
#define ISNILS2(var1,var2,var3,var4) ISNILS(TRIPLES(var1,var2,var3),var4)
#define ISNILS3(var1,var2,var3) ISNILS(DOUBLES(var1,var2),var3)
#define ISNIL(var1,var2) ISNILS2(PREFIX,COMPONENT,var1,var2)
#define ISNILMAIN(var1,var2) ISNILS3(PREFIX,var1,var2)
#define CREATELOGICS(var1,var2) ##var1##_##var2## = ([sideLogic] call CBA_fnc_getSharedGroup) createUnit ["LOGIC", [0, 0, 0], [], 0, "NONE"]
#define CREATELOGICLOCALS(var1,var2) ##var1##_##var2## = "LOGIC" createVehicleLocal [0, 0, 0]
#define CREATELOGICGLOBALS(var1,var2) ##var1##_##var2## = ([sideLogic] call CBA_fnc_getSharedGroup) createUnit ["LOGIC", [0, 0, 0], [], 0, "NONE"]; publicVariable QUOTE(DOUBLES(var1,var2))
#define CREATELOGICGLOBALTESTS(var1,var2) ##var1##_##var2## = ([sideLogic] call CBA_fnc_getSharedGroup) createUnit [QUOTE(DOUBLES(ADDON,logic)), [0, 0, 0], [], 0, "NONE"]
#define GETVARS(var1,var2,var3) (##var1##_##var2 getVariable #var3)
#define GETVARMAINS(var1,var2) GETVARS(var1,MAINLOGIC,var2)
#ifndef PATHTO_SYS
	#define PATHTO_SYS(var1,var2,var3) \MAINPREFIX\##var1\SUBPREFIX\##var2\##var3.sqf
#endif
#ifndef PATHTOF_SYS
	#define PATHTOF_SYS(var1,var2,var3) \MAINPREFIX\##var1\SUBPREFIX\##var2\##var3
#endif
#ifndef PATHTOF2_SYS
	#define PATHTOF2_SYS(var1,var2,var3) MAINPREFIX\##var1\SUBPREFIX\##var2\##var3
#endif
#define PATHTO_R(var1) PATHTOF2_SYS(PREFIX,COMPONENT_C,var1)
#define PATHTO_T(var1) PATHTOF_SYS(PREFIX,COMPONENT_T,var1)
#define PATHTO_M(var1) PATHTOF_SYS(PREFIX,COMPONENT_M,var1)
#define PATHTO_S(var1) PATHTOF_SYS(PREFIX,COMPONENT_S,var1)
#define PATHTO_C(var1) PATHTOF_SYS(PREFIX,COMPONENT_C,var1)
#define PATHTO_F(var1) PATHTO_SYS(PREFIX,COMPONENT_F,var1)
#define QPATHTO_R(var1) QUOTE(PATHTO_R(var1))
#define QPATHTO_T(var1) QUOTE(PATHTO_T(var1))
#define QPATHTO_M(var1) QUOTE(PATHTO_M(var1))
#define QPATHTO_S(var1) QUOTE(PATHTO_S(var1))
#define QPATHTO_C(var1) QUOTE(PATHTO_C(var1))
#define QPATHTO_F(var1) QUOTE(PATHTO_F(var1))
#ifdef DISABLE_COMPILE_CACHE
	#define COMPILE_FILE2_CFG_SYS(var1) compile preProcessFileLineNumbers var1
	#define COMPILE_FILE2_SYS(var1) COMPILE_FILE2_CFG_SYS(var1)
#else
	#define COMPILE_FILE2_CFG_SYS(var1) (var1 call {_slx_xeh_compile = uiNamespace getVariable 'SLX_XEH_COMPILE'; if (isNil '_slx_xeh_compile') then { _this call compile preProcessFileLineNumbers 'x\cba\addons\xeh\init_compile.sqf' } else { _this call _slx_xeh_compile } })
	#define COMPILE_FILE2_SYS(var1) (var1 call SLX_XEH_COMPILE)
#endif
#define COMPILE_FILE_SYS(var1,var2,var3) COMPILE_FILE2_SYS('PATHTO_SYS(var1,var2,var3)')
#define COMPILE_FILE_CFG_SYS(var1,var2,var3) COMPILE_FILE2_CFG_SYS('PATHTO_SYS(var1,var2,var3)')
#define SETVARS(var1,var2) ##var1##_##var2 setVariable
#define SETVARMAINS(var1) SETVARS(var1,MAINLOGIC)
#define GVARMAINS(var1,var2) ##var1##_##var2##
#define CFGSETTINGSS(var1,var2) configFile >> "CfgSettings" >> #var1 >> #var2
#define PREPMAIN_SYS(var1,var2,var3) ##var1##_fnc_##var3 = COMPILE_FILE_SYS(var1,var2,DOUBLES(fnc,var3))
#define PREP_SYS(var1,var2,var3) ##var1##_##var2##_fnc_##var3 = COMPILE_FILE_SYS(var1,var2,DOUBLES(fnc,var3))
#define PREP_SYS2(var1,var2,var3,var4) ##var1##_##var2##_fnc_##var4 = COMPILE_FILE_SYS(var1,var3,DOUBLES(fnc,var4))
#define LSTR(var1) TRIPLES(ADDON,STR,var1)
#define CACHE_DIS_SYS(var1,var2) (isNumber(var1 >> "CfgSettings" >> "CBA" >> "caching" >> QUOTE(var2)) && getNumber(var1 >> "CfgSettings" >> "CBA" >> "caching" >> QUOTE(var2)) != 1)
#define CACHE_DIS(var1) (!isNil "CBA_RECOMPILE" || CACHE_DIS_SYS(configFile,var1) || CACHE_DIS_SYS(missionConfigFile,var1))
#ifndef DEBUG_SETTINGS
	#define DEBUG_SETTINGS [false, true, false]
#endif
#define MSG_INIT QUOTE(Initializing: ADDON version: VERSION)
#define CFGSETTINGS CFGSETTINGSS(PREFIX,COMPONENT)
#define PATHTO(var1) PATHTO_SYS(PREFIX,COMPONENT_F,var1)
#define PATHTOF(var1) PATHTOF_SYS(PREFIX,COMPONENT,var1)
#define COMPILE_FILE(var1) COMPILE_FILE_SYS(PREFIX,COMPONENT_F,var1)
#define COMPILE_FILE_CFG(var1) COMPILE_FILE_CFG_SYS(PREFIX,COMPONENT_F,var1)
#define COMPILE_FILE2(var1) COMPILE_FILE2_SYS('var1')
#define COMPILE_FILE2_CFG(var1) COMPILE_FILE2_CFG_SYS('var1')
#define VERSIONING_SYS(var1) class CfgSettings \
{ \
	class CBA \
	{ \
		class Versioning \
		{ \
			class var1 \
			{ \
			}; \
		}; \
	}; \
};
#define VERSIONING VERSIONING_SYS(PREFIX)
#define GVAR(var1) DOUBLES(ADDON,var1)
#define QGVAR(var1) QUOTE(GVAR(var1))
#define GVARMAIN(var1) GVARMAINS(PREFIX,var1)
#define SETTINGS DOUBLES(PREFIX,settings)
#define CREATELOGIC CREATELOGICS(PREFIX,COMPONENT)
#define CREATELOGICGLOBAL CREATELOGICGLOBALS(PREFIX,COMPONENT)
#define CREATELOGICGLOBALTEST CREATELOGICGLOBALTESTS(PREFIX,COMPONENT)
#define CREATELOGICLOCAL CREATELOGICLOCALS(PREFIX,COMPONENT)
#define CREATELOGICMAIN CREATELOGICS(PREFIX,MAINLOGIC)
#define GETVAR(var1) GETVARS(PREFIX,COMPONENT,var1)
#define SETVAR SETVARS(PREFIX,COMPONENT)
#define SETVARMAIN SETVARMAINS(PREFIX)
#define IFCOUNT(var1,var2,var3) if (count ##var1 > ##var2) then { ##var3 = ##var1 select ##var2 };
#define PREP(var1) PREP_SYS2(PREFIX,COMPONENT,COMPONENT_F,var1)
#define PREPMAIN(var1) PREPMAIN_SYS(PREFIX,COMPONENT_F,var1)
#define FUNC(var1) TRIPLES(ADDON,fnc,var1)
#define FUNCMAIN(var1) TRIPLES(PREFIX,fnc,var1)
#define FUNC_INNER(var1,var2) TRIPLES(DOUBLES(PREFIX,var1),fnc,var2)
#ifndef PRELOAD_ADDONS
	#define PRELOAD_ADDONS class CfgAddons \
{ \
	class PreloadAddons \
	{ \
		class ADDON \
		{ \
			list[]={ QUOTE(ADDON) }; \
		}; \
	}; \
}
#endif
#define ARG_1(A,B) ((A) select (B))
#define ARG_2(A,B,C) (ARG_1(ARG_1(A,B),C))
#define ARG_3(A,B,C,D) (ARG_1(ARG_2(A,B,C),D))
#define ARG_4(A,B,C,D,E) (ARG_1(ARG_3(A,B,C,D),E))
#define ARG_5(A,B,C,D,E,F) (ARG_1(ARG_4(A,B,C,D,E),F))
#define ARG_6(A,B,C,D,E,F,G) (ARG_1(ARG_5(A,B,C,D,E,F),G))
#define ARG_7(A,B,C,D,E,F,G,H) (ARG_1(ARG_6(A,B,C,D,E,E,F,G),H))
#define ARG_8(A,B,C,D,E,F,G,H,I) (ARG_1(ARG_7(A,B,C,D,E,E,F,G,H),I))
#define ARR_1(ARG1) ARG1
#define ARR_2(ARG1,ARG2) ARG1, ARG2
#define ARR_3(ARG1,ARG2,ARG3) ARG1, ARG2, ARG3
#define ARR_4(ARG1,ARG2,ARG3,ARG4) ARG1, ARG2, ARG3, ARG4
#define ARR_5(ARG1,ARG2,ARG3,ARG4,ARG5) ARG1, ARG2, ARG3, ARG4, ARG5
#define ARR_6(ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) ARG1, ARG2, ARG3, ARG4, ARG5, ARG6
#define ARR_7(ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7
#define ARR_8(ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8
#define FORMAT_1(STR,ARG1) format[STR, ARG1]
#define FORMAT_2(STR,ARG1,ARG2) format[STR, ARG1, ARG2]
#define FORMAT_3(STR,ARG1,ARG2,ARG3) format[STR, ARG1, ARG2, ARG3]
#define FORMAT_4(STR,ARG1,ARG2,ARG3,ARG4) format[STR, ARG1, ARG2, ARG3, ARG4]
#define FORMAT_5(STR,ARG1,ARG2,ARG3,ARG4,ARG5) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5]
#define FORMAT_6(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6]
#define FORMAT_7(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7]
#define FORMAT_8(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8]
#define DISPLAY(A) (findDisplay A)
#define CONTROL(A) DISPLAY(A) displayCtrl
#define IS_META_SYS(VAR,TYPE) (if (isNil {VAR}) then { false } else { (typeName (VAR)) == TYPE })
#define IS_ARRAY(VAR)    IS_META_SYS(VAR,"ARRAY")
#define IS_BOOL(VAR)     IS_META_SYS(VAR,"BOOL")
#define IS_CODE(VAR)     IS_META_SYS(VAR,"CODE")
#define IS_CONFIG(VAR)   IS_META_SYS(VAR,"CONFIG")
#define IS_CONTROL(VAR)  IS_META_SYS(VAR,"CONTROL")
#define IS_DISPLAY(VAR)  IS_META_SYS(VAR,"DISPLAY")
#define IS_GROUP(VAR)    IS_META_SYS(VAR,"GROUP")
#define IS_OBJECT(VAR)   IS_META_SYS(VAR,"OBJECT")
#define IS_SCALAR(VAR)   IS_META_SYS(VAR,"SCALAR")
#define IS_SCRIPT(VAR)   IS_META_SYS(VAR,"SCRIPT")
#define IS_SIDE(VAR)     IS_META_SYS(VAR,"SIDE")
#define IS_STRING(VAR)   IS_META_SYS(VAR,"STRING")
#define IS_TEXT(VAR)     IS_META_SYS(VAR,"TEXT")
#define IS_LOCATION(VAR) IS_META_SYS(VAR,"LOCATION")
#define IS_BOOLEAN(VAR)  IS_BOOL(VAR)
#define IS_FUNCTION(VAR) IS_CODE(VAR)
#define IS_INTEGER(VAR)  (if ( IS_SCALAR(VAR) ) then { (floor(VAR) == (VAR)) } else { false })
#define IS_NUMBER(VAR)   IS_SCALAR(VAR)
#define SCRIPT(NAME) \
	scriptName 'PREFIX\COMPONENT\NAME'
#define EXPLODE_1_SYS(ARRAY,A) A = if (IS_ARRAY((ARRAY))) then { (ARRAY) select 0 } else { ARRAY }
#define EXPLODE_1(ARRAY,A) EXPLODE_1_SYS(ARRAY,A); TRACE_1("EXPLODE_1, " + QUOTE(ARRAY),A)
#define EXPLODE_1_PVT(ARRAY,A) \
	private #A; \
	EXPLODE_1(ARRAY,A)
#define EXPLODE_2_SYS(ARRAY,A,B) EXPLODE_1_SYS(ARRAY,A); B = (ARRAY) select 1
#define EXPLODE_2(ARRAY,A,B) EXPLODE_2_SYS(ARRAY,A,B); TRACE_2("EXPLODE_2, " + QUOTE(ARRAY),A,B)
#define EXPLODE_2_PVT(ARRAY,A,B) \
	private [#A,#B]; \
	EXPLODE_2(ARRAY,A,B)
#define EXPLODE_3_SYS(ARRAY,A,B,C) EXPLODE_2_SYS(ARRAY,A,B); C = (ARRAY) select 2
#define EXPLODE_3(ARRAY,A,B,C) EXPLODE_3_SYS(ARRAY,A,B,C); TRACE_3("EXPLODE_3, " + QUOTE(ARRAY),A,B,C)
#define EXPLODE_3_PVT(ARRAY,A,B,C) \
	private [#A,#B,#C]; \
	EXPLODE_3(ARRAY,A,B,C)
#define EXPLODE_4_SYS(ARRAY,A,B,C,D) EXPLODE_3_SYS(ARRAY,A,B,C); D = (ARRAY) select 3
#define EXPLODE_4(ARRAY,A,B,C,D) EXPLODE_4_SYS(ARRAY,A,B,C,D); TRACE_4("EXPLODE_4, " + QUOTE(ARRAY),A,B,C,D)
#define EXPLODE_4_PVT(ARRAY,A,B,C,D) \
	private [#A,#B,#C,#D]; \
	EXPLODE_4(ARRAY,A,B,C,D)
#define EXPLODE_5_SYS(ARRAY,A,B,C,D,E) EXPLODE_4_SYS(ARRAY,A,B,C,D); E = (ARRAY) select 4
#define EXPLODE_5(ARRAY,A,B,C,D,E) EXPLODE_5_SYS(ARRAY,A,B,C,D,E); TRACE_5("EXPLODE_5, " + QUOTE(ARRAY),A,B,C,D,E)
#define EXPLODE_5_PVT(ARRAY,A,B,C,D,E) \
	private [#A,#B,#C,#D,#E]; \
	EXPLODE_5(ARRAY,A,B,C,D,E)
#define EXPLODE_6_SYS(ARRAY,A,B,C,D,E,F) EXPLODE_5_SYS(ARRAY,A,B,C,D,E); F = (ARRAY) select 5
#define EXPLODE_6(ARRAY,A,B,C,D,E,F) EXPLODE_6_SYS(ARRAY,A,B,C,D,E,F); TRACE_6("EXPLODE_6, " + QUOTE(ARRAY),A,B,C,D,E,F)
#define EXPLODE_6_PVT(ARRAY,A,B,C,D,E,F) \
	private [#A,#B,#C,#D,#E,#F]; \
	EXPLODE_6(ARRAY,A,B,C,D,E,F)
#define EXPLODE_7_SYS(ARRAY,A,B,C,D,E,F,G) EXPLODE_6_SYS(ARRAY,A,B,C,D,E,F); G = (ARRAY) select 6
#define EXPLODE_7(ARRAY,A,B,C,D,E,F,G) EXPLODE_7_SYS(ARRAY,A,B,C,D,E,F,G); TRACE_7("EXPLODE_7, " + QUOTE(ARRAY),A,B,C,D,E,F,G)
#define EXPLODE_7_PVT(ARRAY,A,B,C,D,E,F,G) \
	private [#A,#B,#C,#D,#E,#F,#G]; \
	EXPLODE_7(ARRAY,A,B,C,D,E,F,G)
#define EXPLODE_8_SYS(ARRAY,A,B,C,D,E,F,G,H) EXPLODE_7_SYS(ARRAY,A,B,C,D,E,F,G); H = (ARRAY) select 7
#define EXPLODE_8(ARRAY,A,B,C,D,E,F,G,H) EXPLODE_8_SYS(ARRAY,A,B,C,D,E,F,G,H); TRACE_8("EXPLODE_8, " + QUOTE(ARRAY),A,B,C,D,E,F,G,H)
#define EXPLODE_8_PVT(ARRAY,A,B,C,D,E,F,G,H) \
	private [#A,#B,#C,#D,#E,#F,#G,#H]; \
	EXPLODE_8(ARRAY,A,B,C,D,E,F,G,H)
#define EXPLODE_9_SYS(ARRAY,A,B,C,D,E,F,G,H,I) EXPLODE_8_SYS(ARRAY,A,B,C,D,E,F,G,H); I = (ARRAY) select 8
#define EXPLODE_9(ARRAY,A,B,C,D,E,F,G,H,I) EXPLODE_9_SYS(ARRAY,A,B,C,D,E,F,G,H,I); TRACE_9("EXPLODE_9, " + QUOTE(ARRAY),A,B,C,D,E,F,G,H,I)
#define EXPLODE_9_PVT(ARRAY,A,B,C,D,E,F,G,H,I) \
	private [#A,#B,#C,#D,#E,#F,#G,#H,#I]; \
	EXPLODE_9(ARRAY,A,B,C,D,E,F,G,H,I)
#define PARAMS_1(A) EXPLODE_1_PVT(_this,A)
#define PARAMS_2(A,B) EXPLODE_2_PVT(_this,A,B)
#define PARAMS_3(A,B,C) EXPLODE_3_PVT(_this,A,B,C)
#define PARAMS_4(A,B,C,D) EXPLODE_4_PVT(_this,A,B,C,D)
#define PARAMS_5(A,B,C,D,E) EXPLODE_5_PVT(_this,A,B,C,D,E)
#define PARAMS_6(A,B,C,D,E,F) EXPLODE_6_PVT(_this,A,B,C,D,E,F)
#define PARAMS_7(A,B,C,D,E,F,G) EXPLODE_7_PVT(_this,A,B,C,D,E,F,G)
#define PARAMS_8(A,B,C,D,E,F,G,H) EXPLODE_8_PVT(_this,A,B,C,D,E,F,G,H)
#define PARAMS_9(A,B,C,D,E,F,G,H,I) EXPLODE_9_PVT(_this,A,B,C,D,E,F,G,H,I)
#define DEFAULT_PARAM(INDEX,NAME,DEF_VALUE) \
	private #NAME; \
	NAME = [RETNIL(_this), INDEX, DEF_VALUE] call CBA_fnc_defaultParam; \
	TRACE_3("DEFAULT_PARAM",INDEX,NAME,DEF_VALUE)
#define KEY_PARAM(KEY,NAME,DEF_VALUE) \
	private #NAME; \
	NAME = [toLower KEY, toUpper KEY, DEF_VALUE, RETNIL(_this)] call CBA_fnc_getArg; \
	TRACE_3("KEY_PARAM",KEY,NAME,DEF_VALUE)
#define ASSERTION_ERROR(MESSAGE) ERROR_WITH_TITLE("Assertion failed!",MESSAGE)
#define ASSERT_TRUE(CONDITION,MESSAGE) \
	if (not (CONDITION)) then \
	{ \
		ASSERTION_ERROR('Assertion (CONDITION) failed!\n\n' + (MESSAGE)); \
	}
#define ASSERT_FALSE(CONDITION,MESSAGE) \
	if (CONDITION) then \
	{ \
		ASSERTION_ERROR('Assertion (not (CONDITION)) failed!\n\n' + (MESSAGE)) \
	}
#define ASSERT_OP(A,OPERATOR,B,MESSAGE) \
	if (not ((A) OPERATOR (B))) then \
	{ \
		ASSERTION_ERROR('Assertion (A OPERATOR B) failed!\n' + 'A: ' + (str (A)) + '\n' + 'B: ' + (str (B)) + "\n\n" + (MESSAGE)); \
	}
#define ASSERT_DEFINED(VARIABLE,MESSAGE) \
	if (isNil VARIABLE) then \
	{ \
		ASSERTION_ERROR('Assertion (VARIABLE is defined) failed!\n\n' + (MESSAGE)); \
	}
#define DEPRECATE_SYS(OLD_FUNCTION,NEW_FUNCTION) \
	OLD_FUNCTION = { \
		WARNING('Deprecated function used: OLD_FUNCTION (new: NEW_FUNCTION) in ADDON'); \
		if (isNil "_this") then { call NEW_FUNCTION } else { _this call NEW_FUNCTION }; \
	}
#define DEPRECATE(OLD_FUNCTION,NEW_FUNCTION) \
	DEPRECATE_SYS(DOUBLES(PREFIX,OLD_FUNCTION),DOUBLES(PREFIX,NEW_FUNCTION))
#define OBSOLETE_SYS(OLD_FUNCTION,COMMAND_CODE) \
	OLD_FUNCTION = { \
		WARNING('Obsolete function used: (use: OLD_FUNCTION) in ADDON'); \
		if (isNil "_this") then { call COMMAND_CODE } else { _this call COMMAND_CODE }; \
	}
#define OBSOLETE(OLD_FUNCTION,COMMAND_CODE) \
	OBSOLETE_SYS(DOUBLES(PREFIX,OLD_FUNCTION),COMMAND_CODE)
#define BWC_CONFIG(NAME) class NAME { \
		units[] = {}; \
		weapons[] = {}; \
		requiredVersion = REQUIRED_VERSION; \
		requiredAddons[] = {}; \
		version = VERSION; \
}
#define XEH_DISABLED class EventHandlers {}; SLX_XEH_DISABLED = 1
#define XEH_PRE_INIT QUOTE(call COMPILE_FILE(XEH_PreInit_Once))
#define XEH_PRE_CINIT QUOTE(call COMPILE_FILE(XEH_PreClientInit_Once))
#define XEH_PRE_SINIT QUOTE(call COMPILE_FILE(XEH_PreServerInit_Once))
#define XEH_POST_INIT QUOTE(call COMPILE_FILE(XEH_PostInit_Once))
#define XEH_POST_CINIT QUOTE(call COMPILE_FILE(XEH_PostClientInit_Once))
#define XEH_POST_SINIT QUOTE(call COMPILE_FILE(XEH_PostServerInit_Once))