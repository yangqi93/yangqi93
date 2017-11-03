## 文件上传

一. 准备模型
> 必要的属性字段：file  
场景scenarios中要有upload场景，并规定好该场景要校验的字段，还要有upload方法

```php     
public $csv;
public $newName;
public function scenarios()
{
    return array_merge(parent::scenarios(), [
        'upload' => ['csv']
    ]);
}
public function rules()
{
    return [
        ['csv', 'file', 'maxSize' => 1024*1024*2048, 'on' => ['upload']],
        ['csv', 'validateCsv', 'skipOnEmpty' => false, 'on' => ['upload']],
    ];
}
public function upload()
{
    if ($this->validate()) {
        $this->newname = 'CycleParts/' . Yii::$app->session->get('user_id') . '/' . uniqid('batch') . $this->csv->name;
        $dir = pathinfo(Yii::getAlias('@app') . '/runtime/' . $this->newname, PATHINFO_DIRNAME);
        if (!is_dir($dir)) {
            @mkdir($dir, 0777, true);
            clearstatcache();
        }
        if ($this->csv->saveAs(Yii::getAlias('@app') . '/runtime/' . $this->newname)) {
            return true;
        }
    }
    return false;
}
```
  
二. 首先在action中将这个模型实例化
```php
public function actionProcess($id)
{
    $uploadModel = new PartCycleOrdersParts(['scenario' => 'upload']);
          //接收上传文件
	$uploadModel->csv = UploadedFile::getInstance($uploadModel, 'csv');
	if( Yii::$app->getRequest()->isPost ) {
	    if( $uploadModel->upload() && $uploadModel->saveCyclePartsToRedis($uploadModel->newname, $cycleOrderId)) {
	        Helper::Alert(Yii::t('app','Upload Successful.'), 'success');
	    }
	}
    return $this->render('process', [
        'uploadModel' => $uploadModel,      
    ]);
}
```

三. view页面
```html
<?php $form = ActiveForm::begin([
    'options'   => ['name' => 'import','class' => 'form-inline', 'enctype' => 'multipart/form-data'],
    'action'    => ['parts-upload'],
    'method'    => 'post',
]); ?>
<div class="col-sm-4 form-control-static">
   <?= $form->field($uploadModel, 'csv')->label(false)->fileInput(); ?>
</div>
<?= Html::activeHiddenInput($model, 'id') ?>
<?php ActiveForm::end(); ?>
```