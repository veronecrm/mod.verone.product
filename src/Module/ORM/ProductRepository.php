<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Product\ORM;

use CRM\ORM\Repository;
use CRM\ORM\Entity;
use CRM\Pagination\PaginationInterface;

class ProductRepository extends Repository implements PaginationInterface
{
    public $dbTable = '#__product';

    /**
     * @see CRM\Pagination\PaginationInterface::paginationCount()
     */
    public function paginationCount()
    {
        $request = $this->request();

        $query = [];
        $binds = [];

        if($request->get('letter'))
        {
            $query[] = 'name LIKE :name';
            $binds[':name'] = $request->get('letter').'%';
        }
        if($request->get('q'))
        {
            $query[] = 'name LIKE \'%'.$request->get('q').'%\'';
            $binds[':q'] = $request->get('q');
        }
        if($request->get('category'))
        {
            $query[] = 'category = :category';
            $binds[':category'] = $request->get('category');
        }
        if($request->get('priceFrom'))
        {
            $query[] = 'price >= :priceFrom';
            $binds[':priceFrom'] = $request->get('priceFrom');
        }
        if($request->get('priceTo'))
        {
            $query[] = 'price <= :priceTo';
            $binds[':priceTo'] = $request->get('priceTo');
        }
        if($request->get('sellAllowed'))
        {
            $query[] = 'sellAllowed <= :sellAllowed';
            $binds[':sellAllowed'] = 1;
        }
        if($request->get('qtyInStock'))
        {
            $query[] = 'qtyInStock > :qtyInStock';
            $binds[':qtyInStock'] = 1;
        }

        return $this->countAll(implode(' AND ', $query), $binds);
    }

    /**
     * @see CRM\Pagination\PaginationInterface::paginationGet()
     */
    public function paginationGet($start, $limit)
    {
        $request = $this->request();

        $query = [];
        $binds = [];

        if($request->get('letter'))
        {
            $query[] = 'name LIKE :name';
            $binds[':name'] = $request->get('letter').'%';
        }
        if($request->get('q'))
        {
            $query[] = 'name LIKE \'%'.$request->get('q').'%\'';
            $binds[':q'] = $request->get('q');
        }
        if($request->get('category'))
        {
            $query[] = 'category = :category';
            $binds[':category'] = $request->get('category');
        }
        if($request->get('priceFrom'))
        {
            $query[] = 'price >= :priceFrom';
            $binds[':priceFrom'] = $request->get('priceFrom');
        }
        if($request->get('priceTo'))
        {
            $query[] = 'price <= :priceTo';
            $binds[':priceTo'] = $request->get('priceTo');
        }
        if($request->get('sellAllowed'))
        {
            $query[] = 'sellAllowed <= :sellAllowed';
            $binds[':sellAllowed'] = 1;
        }
        if($request->get('qtyInStock'))
        {
            $query[] = 'qtyInStock > :qtyInStock';
            $binds[':qtyInStock'] = 1;
        }

        return $this->findAll(implode(' AND ', $query), $binds, $start, $limit);
    }

    public function parseToTimestamp($date)
    {
        return (new \DateTime($date))->getTimestamp();
    }

    public function checkEntityDates(Entity $entity)
    {
        if(preg_match('/\d\d\d\d\-\d\d\-\d\d/i', $entity->getSellStart()))
        {
            $entity->setSellStart($this->parseToTimestamp($entity->getSellStart()));
        }
        elseif(is_int($entity->getSellStart()))
        {
            $entity->setSellStart(intval($entity->getSellStart()));
        }
        else
        {
            $entity->setSellStart(0);
        }

        if(preg_match('/\d\d\d\d\-\d\d\-\d\d/i', $entity->getSellEnd()))
        {
            $entity->setSellEnd($this->parseToTimestamp($entity->getSellEnd()));
        }
        elseif(is_int($entity->getSellEnd()))
        {
            $entity->setSellEnd(intval($entity->getSellEnd()));
        }
        else
        {
            $entity->setSellEnd(0);
        }

        if(preg_match('/\d\d\d\d\-\d\d\-\d\d/i', $entity->getSupportStart()))
        {
            $entity->setSupportStart($this->parseToTimestamp($entity->getSupportStart()));
        }
        elseif(is_int($entity->getSupportStart()))
        {
            $entity->setSupportStart(intval($entity->getSupportStart()));
        }
        else
        {
            $entity->setSupportStart(0);
        }

        if(preg_match('/\d\d\d\d\-\d\d\-\d\d/i', $entity->getSupportEnd()))
        {
            $entity->setSupportEnd($this->parseToTimestamp($entity->getSupportEnd()));
        }
        elseif(is_int($entity->getSupportEnd()))
        {
            $entity->setSupportEnd(intval($entity->getSupportEnd()));
        }
        else
        {
            $entity->setSupportEnd(0);
        }

        return $this;
    }

    public function getFieldsNames()
    {
        return [
            'id'          => 'ID',
            'owner'       => $this->t('recordOwner'),
            'category'     => $this->t('productCategory'),
            'serialNumber' => $this->t('productSerialNumber'),
            'manufacturerSerialNumber' => $this->t('productManufacturerSerialNumber'),
            'owner'        => $this->t('owner'),
            'name'         => $this->t('name'),
            'price'        => $this->t('productPrice'),
            'tax'          => $this->t('productTax'),
            'qtyInStock'   => $this->t('productQtyInStock'),
            'unit'         => $this->t('productMeasureUnit'),
            'sellStart'    => $this->t('productSellStart'),
            'sellEnd'      => $this->t('productSellEnd'),
            'sellAllowed'  => $this->t('productSellAllowed'),
            'supportStart' => $this->t('productSupportStart'),
            'supportEnd'   => $this->t('productSupportEnd'),
            'description'  => $this->t('description'),
            'created'      => $this->t('addDate'),
            'modified'     => $this->t('modificationDate')
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function getEndValue(Entity $entity, $field)
    {
        if($field == 'tax')
        {
            $tax = $this->get('helper.tax')->get($entity->getTax());

            if($tax)
            {
                return $tax->name;
            }
        }

        if($field == 'unit')
        {
            $unit = $this->get('helper.measureUnit')->name($entity->getUnit());

            if($unit)
            {
                return $unit;
            }
        }

        if($field == 'sellStart')
        {
            return $this->datetime()->dateShort($entity->getSellStart());
        }
        if($field == 'sellEnd')
        {
            return $this->datetime()->dateShort($entity->getSellEnd());
        }
        if($field == 'supportStart')
        {
            return $this->datetime()->dateShort($entity->getSupportStart());
        }
        if($field == 'supportEnd')
        {
            return $this->datetime()->dateShort($entity->getSupportEnd());
        }
        if($field == 'sellAllowed')
        {
            return $entity->getSellAllowed() ? $this->t('syes') : $this->t('sno');
        }

        if($field == 'owner')
        {
            $user = $this->repo('User', 'User')->find($entity->getOwner());

            if($user)
                return $user->getName().' (ID:'.$entity->getOwner().')';
            else
                return $entity->getOwner();
        }

        return parent::getEndValue($entity, $field);
    }
}
