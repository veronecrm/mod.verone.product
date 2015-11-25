<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Product\Plugin;

use CRM\App\Module\Plugin;

class Calendar extends Plugin
{
    public function eventsGroups()
    {
        return [
            [
                'ordering'  => 0,
                'id'        => 'Product.Product',
                'name'      => $this->t('products')
            ]
        ];
    }

    public function eventsFromRange($from, $to)
    {
        $products = $this->repo('Product', 'Product')->findAll();
        $calendar = $this->repo('Event', 'Calendar');
        $result   = [];
        $datetime = $this->datetime();

        $dates = [
            'getSellStart'    => $this->t('productProductSellStart'),
            'getSellEnd'      => $this->t('productProductSellEnd'),
            'getSupportStart' => $this->t('productProductSupportStart'),
            'getSupportEnd'   => $this->t('productProductSupportEnd')
        ];

        foreach($products as $product)
        {
            foreach($dates as $method => $name)
            {
                if($product->{$method}() >= $from && $product->{$method}() < $to)
                {
                    $event = [];
                    $event['group']  = 'Product.Product';
                    $event['title']  = $name;
                    $event['start']  = date('Y-m-d', $product->{$method}());
                    $event['startHuman'] = $datetime->dateShort($product->{$method}());

                    $color = $calendar->getEventColorByType(0);

                    $event['color']    = $color['color'];
                    $event['typeName'] = $color['name'];
                    $event['id']       = $method.'.'.$product->getId();
                    $event['editable']    = false;
                    $event['description'] = $name.': '.$product->getName();
                    $event['onClickRedirect'] = $this->createUrl('Product', 'Product', 'summary', [ 'id' => $product->getId() ]);

                    $result[] = $event;
                }
            }
        }

        return $result;
    }

    public function updateEvent($id, $group, array $data)
    {

    }
}
