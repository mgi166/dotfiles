#!/bin/sh

cli=/Applications/KeyRemap4MacBook.app/Contents/Applications/KeyRemap4MacBook_cli.app/Contents/MacOS/KeyRemap4MacBook_cli

$cli set option.emacsmode_optionV 1
/bin/echo -n .
$cli set option.emacsmode_optionBF 1
/bin/echo -n .
$cli set option.emacsmode_controlPNBF 1
/bin/echo -n .
$cli set option.emacsmode_controlV 1
/bin/echo -n .
$cli set remap.jis_unify_eisuu_to_kana 1
/bin/echo -n .
$cli set remap.jis_eisuu2optionL 1
/bin/echo -n .
$cli set option.emacsmode_ex_controlSpace 1
/bin/echo -n .
$cli set option.emacsmode_optionD 1
/bin/echo -n .
$cli set option.emacsmode_optionLtGt 1
/bin/echo -n .
/bin/echo
