#!/bin/sh -e

GFWLIST_URL="http://autoproxy-gfwlist.googlecode.com/svn/trunk/gfwlist.txt"

if [ ! -f gfwlist.txt ]; then
	wget "$GFWLIST_URL" -O gfwlist.b64
	cat gfwlist.b64 | base64 -d > gfwlist.txt
	rm -f gfwlist.b64
fi

cat gfwlist.txt base-gfwlist.txt | sort -u | 
	sed 's#!.\+##; s#|##g; s#@##g; s#http:\/\/##; s#https:\/\/##;' |
	sed '/\*/d; /apple\.com/d; /sina\.cn/d; /sina\.com\.cn/d; /baidu\.com/d' |
	sed '/^[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+$/d' |
	grep '^[0-9a-zA-Z\.-]\+$' | grep '\.' | sed 's#^\.\+##' | sort -u

