#!/bin/sh
# Generates gdkkeysyms bindings for go  from the header file which needs to be given as the first and only argument
# no checking is perform
# ran as ./gdk_keysyms.sh /usr/include/gtk-3.0/gdk/gdkkeysyms.h

output=gdk_keysyms.go
cat > $output <<EOF
package gdk

// generated file

// #cgo pkg-config: gdk-3.0
// #include <gdk/gdkkeysyms.h>
import "C"

type KeyVal uint
EOF

echo 'const (' >> $output
cat $1 | grep '^#define GDK' | sed -r 's/^.*?(GDK_.*?)\ .*$/\1 KeyVal = C\.\1/' >> $output
echo ')' >> $output

gofmt -w  $output
