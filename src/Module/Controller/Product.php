<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Product\Controller;

use CRM\App\Controller\BaseController;
use CRM\Pagination\Paginator;

/**
 * @section mod.Product.Product
 */
class Product extends BaseController
{
    private $eventsNames = [];

    public function onBefore()
    {
        $this->eventsNames = [
            'sellEnd'    => [
                'name' => $this->t('productEventNameSellEnd'),
                'id'   => 'ProductSellEnd'
            ],
            'supportEnd' => [
                'name' => $this->t('productEventNameSupportEnd'),
                'id'   => 'ProductSupportEnd'
            ]
        ];
    }

    /**
     * @access core.module
     */
    public function indexAction($request)
    {
        $paginator = new Paginator($this->repo(), $request->get('page'), $this->createUrl($this->request()->query->all()));

        return $this->render('', [
            'elements'   => $paginator->getElements(),
            'pagination' => $paginator,
            'categories' => $this->repo('Category')->getTree()
        ]);
    }

    /**
     * @access core.read
     */
    public function copyAction($request)
    {
        $product = $this->repo()->find($request->get('id'));

        if(! $product)
        {
            $this->flash('danger', $this->t('productDoesntExists'));
            return $this->redirect('Product', 'Product', 'index');
        }

        $repo = $this->repo('Event', 'Calendar');

        $product->setId(null);

        return $this->render('form', [
            'product'       => $product,
            'owner'         => $this->repo('User', 'User')->findWithComplement($product->getOwner()),
            'eventSellEnd'  => $repo->findForAsset('ProductSellEnd', $product->getId()),
            'eventSupportEnd' => $repo->findForAsset('ProductSupportEnd', $product->getId()),
            'categories'    => $this->repo('Category')->getTree()
        ]);
    }

    /**
     * @access core.write
     */
    public function addAction()
    {
        return $this->render('form', [
            'product'    => $this->entity(),
            'categories' => $this->repo('Category')->getTree()
        ]);
    }

    /**
     * @access core.write
     */
    public function saveAction($request)
    {
        $product = $this->entity()->fillFromRequest($request);
        $product->setOwner($this->user()->getId());
        $product->setCreated(time());
        $product->setPrice(str_replace(',', '.', $product->getPrice()));

        $this->repo()->checkEntityDates($product);
        $this->repo()->save($product);

        $this->openUserHistory($product)->flush('create', $this->t('product'));

        $this->flash('success', $this->t('productSaved'));

        if($request->request->has('apply'))
            return $this->redirect('Product', 'Product', 'edit', [ 'id' => $product->getId() ]);
        else
            return $this->redirect('Product', 'Product', 'index');
    }

    /**
     * @access core.read
     */
    public function editAction($request)
    {
        $product = $this->repo()->find($request->get('id'));

        if(! $product)
        {
            $this->flash('danger', $this->t('productDoesntExists'));
            return $this->redirect('Product', 'Product', 'index');
        }

        return $this->render('form', [
            'product'       => $product,
            'owner'         => $this->repo('User', 'User')->findWithComplement($product->getOwner()),
            'categories'    => $this->repo('Category')->getTree()
        ]);
    }

    /**
     * @access core.write
     */
    public function updateAction($request)
    {
        $repo    = $this->repo();
        $product = $repo->find($request->get('id'));

        if(! $product)
        {
            $this->flash('danger', $this->t('productDoesntExists'));
            return $this->redirect('Product', 'Product', 'index');
        }

        $log = $this->openUserHistory($product);

        $product->fillFromRequest($request);
        $product->setPrice(str_replace(',', '.', $product->getPrice()));
        $product->setModified(time());

        $repo->checkEntityDates($product);

        $log->flush('change', $this->t('product'));

        $repo->save($product);

        if($request->isAJAX())
        {
            return $this->responseAJAX([
                'status'  => 'success',
                'message' => $this->t('productSaved')
            ]);
        }
        else
        {
            $this->flash('success', $this->t('productSaved'));

            if($request->request->has('apply'))
                return $this->redirect('Product', 'Product', 'edit', [ 'id' => $product->getId() ]);
            else
                return $this->redirect('Product', 'Product', 'index');
        }
    }

    /**
     * @access core.delete
     */
    public function deleteAction($request)
    {
        $product = $this->repo()->find($request->get('id'));

        if(! $product)
        {
            $this->flash('danger', $this->t('productDoesntExists'));
            return $this->redirect('Product', 'Product', 'index');
        }

        $this->repo()->delete($product);

        $this->openUserHistory($product)->flush('delete', $this->t('product'));

        $this->flash('success', $this->t('productDeletedSuccess'));

        return $this->redirect('Product', 'Product', 'index');
    }

    /**
     * @access core.read
     */
    public function summaryAction($request)
    {
        $product = $this->repo()->find($request->get('id'));

        if(! $product)
        {
            $this->flash('danger', $this->t('productDoesntExists'));
            return $this->redirect('Product', 'Product', 'index');
        }

        return $this->render('summary', [
            'product' => $product,
            'owner'   => $this->repo('User', 'User')->findWithComplement($product->getOwner()),
            'entity'  => null
        ]);
    }
}
