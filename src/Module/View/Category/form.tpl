<div class="page-header">
    <div class="page-header-content">
        <div class="page-title">
            <h1>
                <i class="fa fa-folder-open"></i>
                <?php echo $app->t($category->getId() ? 'productCategoryEdit' : 'productCategoryNew'); ?>
            </h1>
        </div>
        <div class="heading-elements">
            <div class="heading-btn-group">
                <a href="#" data-form-submit="form" data-form-param="apply" class="btn btn-icon-block btn-link-success">
                    <i class="fa fa-save"></i>
                    <span>{{ t('apply') }}</span>
                </a>
                <a href="#" data-form-submit="form" data-form-param="save" class="btn btn-icon-block btn-link-success">
                    <i class="fa fa-save"></i>
                    <span>{{ t('save') }}</span>
                </a>
                <a href="#" class="btn btn-icon-block btn-link-danger app-history-back">
                    <i class="fa fa-remove"></i>
                    <span>{{ t('cancel') }}</span>
                </a>
            </div>
        </div>
        <div class="heading-elements-toggle">
            <i class="fa fa-ellipsis-h"></i>
        </div>
    </div>
    <div class="breadcrumb-line">
        <ul class="breadcrumb">
            <li><a href="{{ createUrl() }}"><i class="fa fa-home"> </i>Verone</a></li>
            <li><a href="{{ createUrl('Product', 'Product', 'index') }}">{{ t('products') }}</a></li>
            <li><a href="{{ createUrl('Product', 'Category', 'index') }}">{{ t('productCategories') }}</a></li>
            @if $category->getId()
                <li class="active"><a href="{{ createUrl('Product', 'Category', 'edit', [ 'id' => $category->getId() ]) }}">{{ t('productCategoryEdit') }}</a></li>
            @else
                <li class="active"><a href="{{ createUrl('Product', 'Category', 'add') }}">{{ t('productCategoryNew') }}</a></li>
            @endif
        </ul>
    </div>
</div>

<div class="container-fluid">
    <form action="<?php echo $app->createUrl('Product', 'Category', $category->getId() ? 'update' : 'save'); ?>" method="post" id="form" class="form-validation">
        <input type="hidden" name="id" value="<?php echo $category->getId(); ?>" />
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading">{{ t('basicInformations') }}</div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label for="name" class="control-label">{{ t('name') }}</label>
                            <input class="form-control required" type="text" id="name" name="name" autofocus="" value="{{ $category->getName() }}" />
                        </div>
                        @if ! $category->getId()
                            <div class="form-group">
                                <label for="parent" class="control-label">{{ t('productCategoryParent') }}</label>
                                <select name="parent" id="parent" class="form-control">
                                    <option value="0">{{ t('productCategoryMain') }}</option>
                                    @foreach $categories
                                        <option value="{{ $item->getId() }}"><?php echo str_repeat('&ndash;&nbsp;', $item->depth); ?>{{ $item->getName() }}</option>
                                    @endforeach
                                </select>
                            </div>
                        @endif
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
