<div class="page-header">
    <div class="page-header-content">
        <div class="page-title">
            <h1>
                <i class="fa fa-cube"></i>
                {{ t('productSummary') }}
            </h1>
        </div>
        <div class="heading-elements">
            <div class="heading-btn-group">
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
            <li class="active"><a href="{{ createUrl('Product', 'Product', 'edit', [ 'id' => $product->getId() ]) }}">{{ t('product') }} - {{ $product->getName() }}</a></li>
        </ul>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="summary-panel">
                                <h3>{{ $product->getName() }}</h3>
                                <span class="actions">
                                    <a href="{{ createUrl('Product', 'Product', 'edit', [ 'id' => $product->getId() ]) }}" class="btn btn-sm btn-default"><i class="fa fa-pencil"></i> {{ t('edit') }}</a>
                                </span>
                                <div class="summary-details">
                                    <div class="item">
                                        <label>{{ t('productPrice') }}</label>
                                        <div>{{ $app->get('helper.currency')->append($app->get('helper.tax')->calculateGrossPrice($product->getPrice(), $product->getTax())) }} &nbsp; ({{ t('productNet')}}: {{ $app->get('helper.currency')->append($product->getPrice()) }})</div>
                                    </div>
                                    <div class="item">
                                        <label>{{ t('productTax') }}</label>
                                        <div>{{ $app->get('helper.tax')->get($product->getTax())->name }}</div>
                                    </div>
                                    <div class="item">
                                        <label>{{ t('productQtyInStock') }}</label>
                                        <div>{{ $app->get('helper.measureUnit')->append($product->getQtyInStock(), $product->getUnit()) }}</div>
                                    </div>
                                    @if $product->getSerialNumber() || $product->getManufacturerSerialNumber()
                                        <hr />
                                        @if $product->getSerialNumber()
                                            <div class="item">
                                                <label>{{ t('productSerialNumber') }}</label>
                                                <div>{{ $product->getSerialNumber() }}</div>
                                            </div>
                                        @endif
                                        @if $product->getManufacturerSerialNumber()
                                            <div class="item">
                                                <label>{{ t('productManufacturerSerialNumber') }}</label>
                                                <div>{{ $product->getManufacturerSerialNumber() }}</div>
                                            </div>
                                        @endif
                                    @endif
                                </div>
                                @if $product->getDescription()
                                    <hr />
                                    <p>{{ $product->getDescription() }}</p>
                                @endif
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            {{ t('historyOfChanges') }} (<span class="summary-history-total">0</span>)
                        </div>
                        <div class="panel-body">
                            <div class="summary-panel history-summary"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            {{ t('comments') }}
                        </div>
                        <div class="panel-body">
                            <div class="comments-panel"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="contact-delete" tabindex="-1" role="dialog" aria-labelledby="contact-delete-modal-label" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="{{ t('close') }}"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="contact-delete-modal-label">{{ t('contractorContactDeleteConfirmationHeader') }}</h4>
            </div>
            <div class="modal-body">
                {{ t('contractorContactDeleteConfirmationContent') }}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ t('close') }}</button>
                <a href="#" class="btn btn-primary">{{ t('syes') }}</a>
            </div>
        </div>
    </div>
</div>
<script>
    $('#contact-delete').on('show.bs.modal', function (event) {
        $(this).find('.modal-footer a').attr('href', $(event.relatedTarget).attr('data-href'));
    });

    $(function() {
        APP.RecordHistoryLog.create({
            target: '.summary-panel.history-summary',
            targetTotalCount: '.summary-history-total',
            module: 'Product',
            entity: 'Product',
            id: '{{ $product->getId() }}'
        });

        APP.Comments.create({
            target: '.comments-panel',
            module: 'Product',
            entity: 'Product',
            id: '{{ $product->getId() }}'
        });
    });
</script>
