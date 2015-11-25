<div class="page-header">
    <div class="page-header-content">
        <div class="page-title">
            <h1>
                <i class="fa fa-folder-open"></i>
                {{ t('productCategories') }}
            </h1>
        </div>
        <div class="heading-elements">
            <div class="heading-btn-group">
                <a href="{{ createUrl('Product', 'Category', 'add') }}" class="btn btn-icon-block btn-link-success">
                    <i class="fa fa-plus"></i>
                    <span>{{ t('productCategoryNew') }}</span>
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
        </ul>
        <ul class="breadcrumb-elements">
            <li><a href="#" data-toggle="modal" data-target="#categories-update-tree"><i class="fa fa-tree"></i> {{ t('productCategoriesChangeTreeView') }}</a></li>
        </ul>
        <div class="breadcrumb-elements-toggle">
            <i class="fa fa-unsorted"></i>
        </div>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-default table-clicked-rows table-responsive">
                <thead>
                    <tr>
                        <th class="text-center span-1"><input type="checkbox" name="select-all" data-select-all="input_group" /></th>
                        <th>{{ t('name') }}</th>
                        <th class="text-right">{{ t('action') }}</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach $categories
                        <tr data-row-click-target="<?php echo $app->createUrl('Product', 'Category', 'edit', [ 'id' => $item->getId() ]); ?>">
                            <td class="text-center hidden-xs"><input type="checkbox" name="input_group" value="{{ $item->getId() }}" /></td>
                            <td data-th="{{ t('name') }}" class="th"><?php echo str_repeat('&ndash;&nbsp;&nbsp;&nbsp;', $item->depth); ?>{{ $item->getName() }}</td>
                            <td data-th="{{ t('action') }}" class="app-click-prevent">
                                <div class="actions-box">
                                    <div class="btn-group right">
                                        <a href="<?php echo $app->createUrl('Product', 'Category', 'edit', [ 'id' => $item->getId() ]); ?>" class="btn btn-default btn-xs btn-main-action" title="{{ t('edit') }}"><i class="fa fa-pencil"></i></a>
                                        <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" >
                                            <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu with-headline right">
                                            <li class="headline">{{ t('moreOptions') }}</li>
                                            <li><a href="<?php echo $app->createUrl('Product', 'Category', 'edit', [ 'id' => $item->getId() ]); ?>" title="{{ t('edit') }}"><i class="fa fa-pencil"></i> {{ t('edit') }}</a></li>
                                            @if $item->isLast
                                                <li role="separator" class="divider"></li>
                                                <li class="item-danger"><a href="#" data-toggle="modal" data-target="#category-delete" data-href="<?php echo $app->createUrl('Product', 'Category', 'delete', [ 'id' => $item->getId() ]); ?>" title="{{ t('delete') }}"><i class="fa fa-remove danger"></i> {{ t('delete') }}</a></li>
                                            @endif
                                        </ul>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal fade" id="category-delete" tabindex="-1" role="dialog" aria-labelledby="category-delete-modal-label" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content modal-danger">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="{{ t('close') }}"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="category-delete-modal-label">{{ t('productCategoryDeleteConfirmationHeader') }}</h4>
            </div>
            <div class="modal-body">
                {{ t('productCategoryDeleteConfirmationContent') }}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ t('close') }}</button>
                <a href="#" class="btn btn-danger">{{ t('syes') }}</a>
            </div>
        </div>
    </div>
</div>
<?php
    $app->assetter()->load('jstree');
?>
<script>
    var groupsList = [];

    $(document).ready(function() {
        $('#categories-tree').jstree({
            'core': {
                 'check_callback': true,
                 'multiple'      : false
             },
            'plugins': [ 'wholerow', 'dnd' ]
        });

        $('#categories-tree').jstree(true).open_all();
        $('#categories-tree').on('move_node.jstree', function() {
            window.groupsList = [];
            $('#categories-tree').jstree(true).open_all();
            $('#categories-tree input').remove();
            var list = createList($('#categories-tree > ul'), 0);

            for(var i in list)
            {
                $('#categories-tree').append('<input type="hidden" name="parents[' + list[i].id + ']" value="' + list[i].parent + '" />');
            }
        });

        $('#category-delete').on('show.bs.modal', function (event) {
            $(this).find('.modal-footer a').attr('href', $(event.relatedTarget).attr('data-href'));
        });
    });

    function createList(target, parent) {
        target.find('> li').each(function() {
            window.groupsList.push({
                'id'    : $(this).attr('id').split('-')[1],
                'parent': parent
            });

            createList($(this).find('> ul'), $(this).attr('id').split('-')[1]);
        });

        return window.groupsList;
    };
</script>

<div class="modal fade" id="categories-update-tree" tabindex="-1" role="dialog" aria-labelledby="categories-update-tree-modal-label" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="{{ t('close') }}"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="categories-update-tree-modal-label">{{ t('productCategoriesChangeTreeView') }}</h4>
            </div>
            <div class="modal-body">
                <form action="<?php echo $app->createUrl('Product', 'Category', 'updateTree'); ?>" method="post" id="categories-tree-save">
                    <div id="categories-tree">
                        <ul>
                            <?php
                                $lastDepth  = 0;
                                
                                foreach($categories as $i => $item)
                                {
                                    echo '<li id="group-'.$item->getId().'"><span>'.$item->getId().' - '.$item->getName().'</span>';
                                    
                                    if(isset($categories[$i+1]->depth) && $categories[$i+1]->depth > $lastDepth)
                                    {
                                        echo  '<ul>';
                                        $lastDepth = $categories[$i+1]->depth;
                                    }
                                    elseif(isset($categories[$i+1]->depth) && $categories[$i+1]->depth < $lastDepth)
                                    {
                                        echo  str_repeat('</ul>', $lastDepth - $categories[$i+1]->depth);
                                        $lastDepth = $categories[$i+1]->depth;
                                    }
                                    else
                                    {
                                        echo  '</li>';
                                    }
                                }
                            ?>
                        </ul>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ t('close') }}</button>
                <a href="#" class="btn btn-primary" data-form-submit="categories-tree-save">{{ t('save') }}</a>
            </div>
        </div>
    </div>
</div>
