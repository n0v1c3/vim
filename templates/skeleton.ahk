; Name: launcher.ahk
; Description: AHK script launcher and manager
; Authors: Travis Gall

; AHK recommendations
#NoEnv 
SendMode Input

; Working directory relative to the script directory
SetWorkingDir %A_ScriptDir%
; Replace old script with new script without confirmation
#SingleInstance Force
