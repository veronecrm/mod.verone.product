<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Product\Plugin;

use CRM\App\Module\Plugin;

class Links extends Plugin
{
    public function mainMenu()
    {
        if($this->acl('mod.Product.Product', 'mod.Product')->isAllowed('core.module'))
        {
            return [
                [
                    'ordering' => 10,
                    'icon' => 'fa fa-cube',
                    'name' => $this->t('products'),
                    'href' => $this->createUrl('Product', 'Product'),
                    'module' => 'Product'
                ]
            ];
        }
    }
}
