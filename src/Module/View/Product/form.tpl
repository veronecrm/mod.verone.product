<?php $app->assetter()->load('datetimepicker'); ?>

<div class="page-header">
    <div class="page-header-content">
        <div class="page-title">
            <h1>
                <i class="fa fa-cube"></i>
                <?php echo $app->t($product->getId() ? 'productEdit' : 'productNew'); ?>
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
            @if $product->getId()
                <li class="active"><a href="{{ createUrl('Product', 'Product', 'edit', [ 'id' => $product->getId() ]) }}">{{ t('productEdit') }}</a></li>
            @else
                <li class="active"><a href="{{ createUrl('Product', 'Product', 'add') }}">{{ t('productNew') }}</a></li>
            @endif
        </ul>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <form action="<?php echo $app->createUrl('Product', 'Product', $product->getId() ? 'update' : 'save'); ?>" method="post" id="form" class="form-validation">
                <input type="hidden" name="id" value="{{ $product->getId() }}" />
                <div class="row">
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">{{ t('basicInformations') }}</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="name" class="control-label">{{ t('productName') }}</label>
                                    <input class="form-control required" type="text" id="name" name="name" autofocus="" value="{{ $product->getName() }}" />
                                </div>
                                <div class="form-group">
                                    <label for="category" class="control-label">{{ t('productCategory') }}</label>
                                    <select name="category" id="category" class="form-control">
                                        <option value="0">{{ t('productUncategorized') }}</option>
                                        @foreach $categories
                                            <option value="{{ $item->getId() }}"<?php echo $product->getCategory() == $item->getId() ? ' selected="selected"' : ''; ?>><?php echo str_repeat('&ndash;&nbsp;&nbsp;&nbsp;', $item->depth); ?>{{ $item->getName() }}</option>
                                        @endforeach
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="tax" class="control-label">{{ t('productTax') }}</label>
                                    <select name="tax" id="tax" class="form-control">
                                        @foreach $app->get('helper.tax')->all()
                                            <option value="{{ $item->id }}"<?php echo $product->getTax() == $item->id ? ' selected="selected"' : ''; ?>>{{ $item->name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="price" class="control-label">{{ t('productPriceNet') }}</label>
                                    <input class="form-control" type="text" id="price" name="price" value="{{ $product->getPrice() }}" />
                                </div>
                                <div class="form-group">
                                    <label for="qtyInStock" class="control-label">{{ t('productQtyInStock') }}</label>
                                    <input class="form-control" type="text" id="qtyInStock" name="qtyInStock" value="{{ $product->getQtyInStock() }}" />
                                </div>
                                <div class="form-group">
                                    <label for="unit" class="control-label">{{ t('productMeasureUnit') }}</label>
                                    <select name="unit" id="unit" class="form-control">
                                        @foreach $app->get('helper.measureUnit')->all()
                                            <option value="{{ $item->id }}"<?php echo $product->getUnit() == $item->id ? ' selected="selected"' : ''; ?>>{{ $item->name }} ({{ $item->unit }})</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">{{ t('productSpecifyDetails') }}</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="serialNumber" class="control-label">{{ t('productSerialNumber') }}</label>
                                    <input class="form-control" type="text" id="serialNumber" name="serialNumber" value="{{ $product->getSerialNumber() }}" />
                                </div>
                                <div class="form-group">
                                    <label for="manufacturerSerialNumber" class="control-label">{{ t('productManufacturerSerialNumber') }}</label>
                                    <input class="form-control" type="text" id="manufacturerSerialNumber" name="manufacturerSerialNumber" value="{{ $product->getManufacturerSerialNumber() }}" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">{{ t('productSellingAndSupports') }}</div>
                            <div class="panel-body">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="sellStart" class="control-label">{{ t('productSellStart') }}</label>
                                                <div class="input-group date">
                                                    <input class="form-control" type="text" id="sellStart" name="sellStart" value="{{ $product->getSellStart() ? date('Y-m-d', $product->getSellStart()) : '' }}" />
                                                    <span class="input-group-addon calendar-open">
                                                        <span class="fa fa-calendar"></span>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="sellEnd" class="control-label">{{ t('productSellEnd') }}</label>
                                                <div class="input-group date">
                                                    <input class="form-control" type="text" id="sellEnd" name="sellEnd" value="{{ $product->getSellEnd() ? date('Y-m-d', $product->getSellEnd()) : '' }}" />
                                                    <span class="input-group-addon calendar-open">
                                                        <span class="fa fa-calendar"></span>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="sellAllowed" class="control-label">{{ t('productSellAllowed') }}</label>
                                                <select name="sellAllowed" id="sellAllowed" class="form-control">
                                                    <option value="1"<?php echo $product->getTax() == 1 ? ' selected="selected"' : ''; ?>>{{ t('syes') }}</option>
                                                    <option value="0"<?php echo $product->getTax() == 0 ? ' selected="selected"' : ''; ?>>{{ t('sno') }}</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="supportStart" class="control-label">{{ t('productSupportStart') }}</label>
                                                <div class="input-group date">
                                                    <input class="form-control" type="text" id="supportStart" name="supportStart" value="{{ $product->getSupportStart() ? date('Y-m-d', $product->getSupportStart()) : '' }}" />
                                                    <span class="input-group-addon calendar-open">
                                                        <span class="fa fa-calendar"></span>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="supportEnd" class="control-label">{{ t('productSupportEnd') }}</label>
                                                <div class="input-group date">
                                                    <input class="form-control" type="text" id="supportEnd" name="supportEnd" value="{{ $product->getSupportEnd() ? date('Y-m-d', $product->getSupportEnd()) : '' }}" />
                                                    <span class="input-group-addon calendar-open">
                                                        <span class="fa fa-calendar"></span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading">{{ t('additionallyInformations') }}</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="description" class="control-label">{{ t('enterDescription') }}</label>
                                    <textarea class="form-control auto-grow" id="description" name="description">{{ $product->getDescription() }}</textarea>
                                </div>
                            </div>
                        </div>

                        @if $product->getId()
                            <div class="panel panel-default">
                                <div class="panel-heading">{{ t('summation') }}</div>
                                <div class="panel-body">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="trade" class="control-label">{{ t('recordOwner') }}</label>
                                                    <p class="form-control-static">{{ $owner->getName() }}</p>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="trade" class="control-label">{{ t('addDate') }}</label>
                                                    <p class="form-control-static" data-toggle="tooltip" data-placement="left" title="{{ $app->datetime($product->getCreated()) }}"><?php echo $app->datetime()->timeAgo($product->getCreated()) ?></p>
                                                </div>
                                                <div class="form-group">
                                                    <label for="trade" class="control-label">{{ t('modificationDate') }}</label>
                                                    <p class="form-control-static" data-toggle="tooltip" data-placement="left" title="{{ $app->datetime($product->getModified()) }}"><?php echo $app->datetime()->timeAgo($product->getModified()); ?></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        @endif
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
    $(function() {
        $('#sellStart, #sellEnd, #supportStart, #supportEnd')
            .datetimepicker({format:'YYYY-MM-DD', defaultDate:'<?php echo date('Y-m-d'); ?>'})
            .parent()
            .find('.input-group-addon.calendar-open')
            .click(function() {
                $(this).parent().find('input').trigger('focus');
            });
    });
</script>
