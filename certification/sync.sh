#!/bin/bash

md_list=`find . -name "*.md"`

i=0
for md in $md_list
do
    echo "<br><br>" > $md
    echo "### [阿里云IoT技术认证文档升级，点击前往查阅！](https://dev.iot.aliyun.com/doc)" >>$md
    i=`expr $i + 1`
    echo "success[$i]: $md"
done
echo "total: $i"
