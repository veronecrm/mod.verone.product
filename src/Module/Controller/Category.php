<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Product\Controller;

use CRM\App\Controller\BaseController;

/**
 * @section mod.Product.Category
 */
class Category extends BaseController
{
    /**
     * @access core.module
     */
    public function indexAction()
    {
        return $this->render('', [
            'categories' => $this->repo('Category')->getTree()
        ]);
    }
    
    /**
     * @access core.write
     */
    public function addAction()
    {
        return $this->render('form', [
            'categories' => $this->repo('Category')->getTree(),
            'category'   => $this->entity('Category')
        ]);
    }

    /**
     * @access core.write
     */
    public function saveAction($request)
    {
        $category = $this->entity('Category')->fillFromRequest($request);
        $this->repo('Category')->save($category);

        $this->openUserHistory($category)->flush('create', $this->t('productCategory'));

        $this->flash('success', $this->t('productCategorySavedSuccess'));

        if($request->get('apply'))
            return $this->redirect('Product', 'Category', 'edit', [ 'id' => $category->getId() ]);
        else
            return $this->redirect('Product', 'Category', 'index');
    }

    /**
     * @access core.read
     */
    public function editAction($request)
    {
        $category = $this->repo('Category')->find($request->get('id'));

        if(! $category)
        {
            $this->flash('danger', $this->t('productCategoryDoesntExists'));
            return $this->redirect('Product', 'Category', 'index');
        }

        return $this->render('form', [
            'category' => $category
        ]);
    }

    /**
     * @access core.write
     */
    public function updateAction($request)
    {
        $category = $this->repo('Category')->find($request->get('id'));

        if(! $category)
        {
            $this->flash('danger', $this->t('productCategoryDoesntExists'));
            return $this->redirect('Product', 'Category', 'index');
        }

        $log = $this->openUserHistory($category);

        $category->fillFromRequest($request);

        $this->repo('Category')->save($category);

        $log->flush('change', $this->t('productCategory'));

        $this->flash('success', $this->t('productCategorySavedSuccess'));

        if($request->get('apply'))
            return $this->redirect('Product', 'Category', 'edit', [ 'id' => $category->getId() ]);
        else
            return $this->redirect('Product', 'Category', 'index');
    }

    /**
     * @access core.delete
     */
    public function deleteAction($request)
    {
        $category = $this->repo('Category')->find($request->get('id'));

        if(! $category)
        {
            $this->flash('danger', $this->t('productCategoryDoesntExists'));
            return $this->redirect('Product', 'Category', 'index');
        }

        $this->repo('Category')->deleteRecursive($category);

        $this->flash('success', $this->t('productCategoryDeletedSuccess'));

        return $this->redirect('Product', 'Category', 'index');
    }

    /**
     * @access core.write
     */
    public function updateTreeAction($request)
    {
        $this->repo('Category')->updateParentsFromArray($request->get('parents'));

        $this->flash('success', $this->t('productCategoryTreeChanged'));
        return $this->redirect('Product', 'Category', 'index');
    }
}
