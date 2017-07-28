#!/bin/sh

#set these paths to match your environment
YII_PATH=$(cd `dirname $0`; pwd)
APIDOC_PATH=$YII_PATH/vendor/yiisoft/yii2-apidoc
OUTPUT=$YII_PATH/web

cd $APIDOC_PATH
./apidoc guide $YII_PATH/note-md $OUTPUT/ --pageTitle='My Note' --guidePrefix= --interactive=0
# repeat the last line for more languages
