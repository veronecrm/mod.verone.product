<?php
    $allowedCategories = $app->acl('mod.Product.Category', 'mod.Product')->isAllowed('core.module');
?>

<div class="page-header">
    <div class="page-header-content">
        <div class="page-title">
            <h1>
                <i class="fa fa-cube"></i>
                {{ t('products') }}
            </h1>
        </div>
        <div class="heading-elements">
            <div class="heading-btn-group">
                <a href="#adv-search-form" data-toggle="collapse" class="btn btn-icon-block btn-link-default">
                    <i class="fa fa-search"></i>
                    <span>{{ t('search') }}</span>
                </a>
                <a href="{{ createUrl('Product', 'Product', 'add') }}" class="btn btn-icon-block btn-link-success">
                    <i class="fa fa-plus"></i>
                    <span>{{ t('productNew') }}</span>
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
        </ul>
        @if $allowedCategories
            <ul class="breadcrumb-elements">
                <li><a href="{{ createUrl('Product', 'Category') }}"><i class="fa fa-folder-open"></i> {{ t('productCategories') }}</a></li>
            </ul>
            <div class="breadcrumb-elements-toggle">
                <i class="fa fa-unsorted"></i>
            </div>
         @endif
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="widget-alphabet-links">
                <div class="links-list">
                    @if $app->request()->get('letter')
                        <a class="cancel" href="<?=$app->request()->buildUriFromSegments([ 'query' => [ 'letter' => '' ] ])?>"><i class="fa fa-remove"></i></a>
                    @endif
                    <?php foreach($app->localisation()->alphabet() as $letter): ?>
                        <a <?php echo ($app->request()->get('letter') == $letter ? 'class="active" ' : ''); ?>href="<?=$app->request()->buildUriFromSegments([ 'query' => [ 'letter' => $letter ] ])?>">{{ $letter }}</a>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php
                $request    = $app->request();
                $units      = $app->get('helper.measureUnit');
                $currencies = $app->get('helper.currency');
            ?>
            <form action="" method="get" id="adv-search-form"<?php echo ($request->get('search') != 1 ? ' class="collapse"' : ' class="collapse in"'); ?>>
                <input type="hidden" name="mod" value="Product" />
                <input type="hidden" name="cnt" value="Product" />
                <input type="hidden" name="act" value="index" />
                <div class="search-container">
                    <div class="panel panel-default">
                        <div class="panel-heading">{{ t('advancedSearch') }}</div>
                        <div class="panel-body">
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="category" class="control-label">{{ t('searchByName') }}</label>
                                            <input type="text" class="form-control" name="q" value="{{ $request->get('q') }}" />
                                        </div>
                                        <div class="form-group">
                                            <label for="category" class="control-label">{{ t('productCategory') }}</label>
                                            <select name="category" id="category" class="form-control">
                                                <option value="">-</option>
                                                @foreach $categories
                                                    <option value="{{ $item->getId() }}"<?php echo ($request->get('category') == $item->getId() ? ' selected="selected"' : ''); ?>><?php echo str_repeat('&ndash;&nbsp;&nbsp;&nbsp;', $item->depth); ?>{{ $item->getName() }}</option>
                                                @endforeach
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="manufacturerSerialNumber" class="control-label">{{ t('priceRange') }}</label>
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <input type="text" class="form-control" name="priceFrom" value="{{ $request->get('priceFrom') }}" placeholder="Od" />
                                                    </div>
                                                    <div class="col-md-6">
                                                        <input type="text" class="form-control" name="priceTo" value="{{ $request->get('priceTo') }}" placeholder="Do" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">{{ t('productSearchAnd') }}</label>
                                            <label><input type="checkbox"<?php echo ($request->get('sellAllowed') == 1 ? ' checked="checked"' : ''); ?> name="sellAllowed" value="1" /> {{ t('productOnlyInSell') }}</label>
                                            <label><input type="checkbox"<?php echo ($request->get('qtyInStock') == 1 ? ' checked="checked"' : ''); ?> name="qtyInStock" value="1" /> {{ t('productOnlyInStock') }}</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="text-right">
                                <a href="#" class="btn btn-success" data-form-submit="adv-search-form" data-form-param="search">{{ t('search') }}</a>
                                <a href="<?php echo $app->createUrl('Product', 'Product', 'index'); ?>" class="btn"><i class="fa fa-remove"></i> {{ t('cancel') }}</a>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <?php
                /**
                 * Here we store QuickEdit values for rows.
                 */
                $jsQuickEdit = [];
            ?>
            <table class="table table-default table-clicked-rows table-responsive">
                <thead>
                    <tr>
                        <th class="text-center span-1"><input type="checkbox" name="select-all" data-select-all="input_user" /></th>
                        <th>{{ t('productName') }}</th>
                        <th>{{ t('productPriceNet') }}</th>
                        <th>{{ t('productQtyInStock') }}</th>
                        <th class="text-right">{{ t('action') }}</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach $elements as $item
                        <tr data-row-click-target="<?php echo $app->createUrl('Product', 'Product', 'summary', [ 'id' => $item->getId() ]); ?>" data-qty="{{ $units->append('{qty}', $item->getUnit()) }}" id="row-{{ $item->getId() }}">
                            <td class="text-center hidden-xs"><input type="checkbox" name="input_user" value="{{ $item->getId() }}" /></td>
                            <td data-th="{{ t('productName') }}" class="product-name th">{{ $item->getName() }}</td>
                            <td data-th="{{ t('productPriceNet') }}" class="product-price">{{ $currencies->append($item->getPrice()) }}</td>
                            <td data-th="{{ t('productQtyInStock') }}" class="product-qty">{{ $units->append($item->getQtyInStock(), $item->getUnit()) }}</td>
                            <td data-th="{{ t('action') }}" class="app-click-prevent">
                                <div class="actions-box">
                                    <button type="button" class="btn btn-default btn-xs quick-edit-trigger hidden-xs" data-quick-edit-id="{{ $item->getId() }}" data-toggle="tooltip" title="{{ t('quickEdit') }}"><i class="fa fa-map-o"></i></button>
                                    <div class="btn-group right">
                                        <a href="<?php echo $app->createUrl('Product', 'Product', 'edit', [ 'id' => $item->getId() ]); ?>" class="btn btn-default btn-xs btn-main-action" title="{{ t('edit') }}"><i class="fa fa-pencil"></i></a>
                                        <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" >
                                            <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu with-headline right">
                                            <li class="headline">{{ t('moreOptions') }}</li>
                                            <li><a href="<?php echo $app->createUrl('Product', 'Product', 'edit', [ 'id' => $item->getId() ]); ?>" title="{{ t('edit') }}"><i class="fa fa-pencil"></i> {{ t('edit') }}</a></li>
                                            <li><a href="<?php echo $app->createUrl('Product', 'Product', 'summary', [ 'id' => $item->getId() ]); ?>" title="{{ t('summary') }}"><i class="fa fa-bars"></i> {{ t('summary') }}</a></li>
                                            <li role="separator" class="divider"></li>
                                            <li><a href="<?php echo $app->createUrl('Product', 'Product', 'copy', [ 'id' => $item->getId() ]); ?>" title="{{ t('productCopy') }}"><i class="fa fa-copy"></i> {{ t('productCopy') }}</a></li>
                                            <li role="separator" class="divider"></li>
                                            <li class="item-danger"><a href="#" data-toggle="modal" data-target="#product-delete" data-href="<?php echo $app->createUrl('Product', 'Product', 'delete', [ 'id' => $item->getId() ]); ?>" title="{{ t('delete') }}"><i class="fa fa-remove danger"></i> {{ t('delete') }}</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <?php
                            $jsQuickEdit[] = "{id:{$item->getId()},name:'{$item->getName()}',price:'{$item->getPrice()}',qtyInStock:'{$item->getQtyInStock()}'}";
                        ?>
                    @endforeach
                </tbody>
            </table>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-6">
                        <form action="" method="get" class="form-inline">
                            <input type="hidden" name="mod" value="Product" />
                            <input type="hidden" name="cnt" value="Product" />
                            <input type="hidden" name="act" value="index" />
                            <input type="hidden" name="search" value="1" />
                            <div class="input-group">
                                <input type="text" class="form-control" name="q" value="{{ $request->get('q') }}" />
                                <span class="input-group-btn">
                                    <button type="submit" class="btn btn-default"><i class="fa fa-search"></i> {{ t('search') }}</button>
                                    @if $request->get('q')
                                        <a href="<?php echo $app->createUrl('Product', 'Product', 'index'); ?>" class="btn"><i class="fa fa-remove"></i> {{ t('cancel') }}</a>
                                    @endif
                                </span>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6">
                        {{ $pagination|raw }}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="product-delete" tabindex="-1" role="dialog" aria-labelledby="product-delete-modal-label" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content modal-danger">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="{{ t('close') }}"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="product-delete-modal-label">{{ t('productDeleteConfirmationHeader') }}</h4>
            </div>
            <div class="modal-body">
                {{ t('productDeleteConfirmationContent') }}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ t('close') }}</button>
                <a href="#" class="btn btn-danger">{{ t('syes') }}</a>
            </div>
        </div>
    </div>
</div>

<div class="quick-edit-form">
    <div class="qef-cnt">
        <h4>{{ t('quickEdit') }}</h4>
        <form action="" method="post" class="form-validation" id="product-quick-edit">
            <div class="form-group">
                <label for="name" class="control-label">{{ t('productName') }}</label>
                <input class="form-control required" type="text" id="name" name="name" value="" />
            </div>
            <div class="form-group">
                <label for="price" class="control-label">{{ t('productPriceNet') }}</label>
                <input class="form-control" type="text" id="price" name="price" value="" />
            </div>
            <div class="form-group">
                <label for="qtyInStock" class="control-label">{{ t('productQtyInStock') }}</label>
                <input class="form-control" type="text" id="qtyInStock" name="qtyInStock" value="" />
            </div>
        </form>
    </div>
    <div class="bottom-actions">
        <button type="button" class="btn btn-circle btn-secondary btn-quick-edit-close left" data-toggle="tooltip" title="{{ t('close') }}"><i class="fa fa-angle-double-left"></i></button>
        <a href="#" class="btn btn-circle btn-default" data-toggle="tooltip" title="{{ t('fullEdition') }}"><i class="fa fa-pencil"></i></a>
        <button type="button" class="btn btn-circle btn-success btn-quick-edit-save" data-toggle="tooltip" title="{{ t('save') }}"><i class="fa fa-save"></i></button>
    </div>
</div>
<script>
    $(function() {
        $('#product-delete').on('show.bs.modal', function (event) {
            $(this).find('.modal-footer a').attr('href', $(event.relatedTarget).attr('data-href'));
        });

        APP.QuickEdit.create({
            url: APP.createUrl('Product', 'Product', 'update'),
            src: [ <?php echo implode(', ', $jsQuickEdit); ?> ],
            onChange: function(id) {
                $('.quick-edit-form .bottom-actions a.btn-default').attr('href', APP.createUrl('Product', 'Product', 'edit', { id: id }));
            },
            onSave: function(values) {
                if(! APP.FormValidation.validateForm($('#product-quick-edit')))
                {
                    return false;
                }

                var row = $('#row-' + values.id);
                row.find('.product-name').text(values.name);
                row.find('.product-price').text('{{ $currencies->append('{price}') }}'.replace('{price}', values.price));
                row.find('.product-qty').text(row.attr('data-qty').replace('{qty}', values.qtyInStock));

                return values;
            }
        });
    });
</script>
