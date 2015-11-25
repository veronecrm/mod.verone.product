<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Product\ORM;

use CRM\ORM\Repository;

class CategoryRepository extends Repository
{
    public $dbTable = '#__product_category';

    private $treeResultTemp = [];

    public function findChildren($id)
    {
        return parent::findAll('parent = :parent ORDER BY name ASC', [
            ':parent' => $id
        ]);
    }

    public function updateParentsFromArray(array $data)
    {
        foreach($data as $id => $parent)
        {
            $category = $this->find($id);

            if($category)
            {
                $log = $this->openUserHistory($category);

                $category->setParent($parent);

                $this->save($category);

                $log->flush('change', $this->t('productCategory'));
            }
        }
    }

    public function deleteRecursive($category)
    {
        $this->delete($category);

        $this->openUserHistory($category)->flush('delete', $this->t('productCategory'));

        foreach($this->findChildren($category->getId()) as $child)
        {
            $this->deleteRecursive($child);
        }
    }

    public function getTree()
    {
        $result = $this->createTree(0);

        $this->treeResultTemp = [];

        return $result;
    }

    public function getFieldsNames()
    {
        return [
            'parent' => $this->t('productCategoryParent'),
            'name'   => $this->t('name')
        ];
    }

    private function createTree($parent, $depth = 0, $returnCount = false)
    {
        $groups = $this->findChildren($parent);

        foreach($groups as $group)
        {
            $group->depth = $depth;

            $this->treeResultTemp[] = $group;

            $count = $this->createTree($group->getId(), $depth + 1, true);

            if($count)
            {
                $group->isLast = false;
            }
            else
            {
                $group->isLast = true;
            }
        }

        if($returnCount)
        {
            return count($groups);
        }
        else
        {
            return $this->treeResultTemp;
        }
    }
}
