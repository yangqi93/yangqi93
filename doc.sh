#!/bin/sh

#set these paths to match your environment
YII_PATH=~/www/mds-guide
APIDOC_PATH=~/www/mds-guide/vendor/yiisoft/yii2-apidoc
OUTPUT=~/www/mds-guide/web

cd $APIDOC_PATH
./apidoc guide $YII_PATH/note-md $OUTPUT/note --pageTitle='My Note' --guidePrefix= --interactive=0
# repeat the last line for more languages
