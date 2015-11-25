<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Product\ORM;

use CRM\ORM\Entity;

class Product extends Entity
{
    protected $id;
    protected $category;
    protected $serialNumber;
    protected $manufacturerSerialNumber;
    protected $owner;
    protected $name;
    protected $price;
    protected $tax;
    protected $qtyInStock;
    protected $unit;
    protected $sellStart;
    protected $sellEnd;
    protected $sellAllowed;
    protected $supportStart;
    protected $supportEnd;
    protected $description;
    protected $created;
    protected $modified;

    /**
     * Gets the id.
     *
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Sets the $id.
     *
     * @param mixed $id the id
     *
     * @return self
     */
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }

    /**
     * Gets the category.
     *
     * @return mixed
     */
    public function getCategory()
    {
        return $this->category;
    }

    /**
     * Sets the $category.
     *
     * @param mixed $category the category
     *
     * @return self
     */
    public function setCategory($category)
    {
        $this->category = $category;

        return $this;
    }

    /**
     * Gets the serialNumber.
     *
     * @return mixed
     */
    public function getSerialNumber()
    {
        return $this->serialNumber;
    }

    /**
     * Sets the $serialNumber.
     *
     * @param mixed $serialNumber the serial number
     *
     * @return self
     */
    public function setSerialNumber($serialNumber)
    {
        $this->serialNumber = $serialNumber;

        return $this;
    }

    /**
     * Gets the manufacturerSerialNumber.
     *
     * @return mixed
     */
    public function getManufacturerSerialNumber()
    {
        return $this->manufacturerSerialNumber;
    }

    /**
     * Sets the $manufacturerSerialNumber.
     *
     * @param mixed $manufacturerSerialNumber the manufacturer serial number
     *
     * @return self
     */
    public function setManufacturerSerialNumber($manufacturerSerialNumber)
    {
        $this->manufacturerSerialNumber = $manufacturerSerialNumber;

        return $this;
    }

    /**
     * Gets the owner.
     *
     * @return mixed
     */
    public function getOwner()
    {
        return $this->owner;
    }

    /**
     * Sets the $owner.
     *
     * @param mixed $owner the owner
     *
     * @return self
     */
    public function setOwner($owner)
    {
        $this->owner = $owner;

        return $this;
    }

    /**
     * Gets the name.
     *
     * @return mixed
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Sets the $name.
     *
     * @param mixed $name the name
     *
     * @return self
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Gets the price.
     *
     * @return mixed
     */
    public function getPrice()
    {
        return $this->price;
    }

    /**
     * Sets the $price.
     *
     * @param mixed $price the price
     *
     * @return self
     */
    public function setPrice($price)
    {
        $this->price = $price;

        return $this;
    }

    /**
     * Gets the tax.
     *
     * @return mixed
     */
    public function getTax()
    {
        return $this->tax;
    }

    /**
     * Sets the $tax.
     *
     * @param mixed $tax the tax
     *
     * @return self
     */
    public function setTax($tax)
    {
        $this->tax = $tax;

        return $this;
    }

    /**
     * Gets the qtyInStock.
     *
     * @return mixed
     */
    public function getQtyInStock()
    {
        return $this->qtyInStock;
    }

    /**
     * Sets the $qtyInStock.
     *
     * @param mixed $qtyInStock the qty in stock
     *
     * @return self
     */
    public function setQtyInStock($qtyInStock)
    {
        $this->qtyInStock = $qtyInStock;

        return $this;
    }

    /**
     * Gets the unit.
     *
     * @return mixed
     */
    public function getUnit()
    {
        return $this->unit;
    }

    /**
     * Sets the $unit.
     *
     * @param mixed $unit the unit
     *
     * @return self
     */
    public function setUnit($unit)
    {
        $this->unit = $unit;

        return $this;
    }

    /**
     * Gets the sellStart.
     *
     * @return mixed
     */
    public function getSellStart()
    {
        return $this->sellStart;
    }

    /**
     * Sets the $sellStart.
     *
     * @param mixed $sellStart the sell start
     *
     * @return self
     */
    public function setSellStart($sellStart)
    {
        $this->sellStart = $sellStart;

        return $this;
    }

    /**
     * Gets the sellEnd.
     *
     * @return mixed
     */
    public function getSellEnd()
    {
        return $this->sellEnd;
    }

    /**
     * Sets the $sellEnd.
     *
     * @param mixed $sellEnd the sell end
     *
     * @return self
     */
    public function setSellEnd($sellEnd)
    {
        $this->sellEnd = $sellEnd;

        return $this;
    }

    /**
     * Gets the sellAllowed.
     *
     * @return mixed
     */
    public function getSellAllowed()
    {
        return $this->sellAllowed;
    }

    /**
     * Sets the $sellAllowed.
     *
     * @param mixed $sellAllowed the sell allowed
     *
     * @return self
     */
    public function setSellAllowed($sellAllowed)
    {
        $this->sellAllowed = $sellAllowed;

        return $this;
    }

    /**
     * Gets the supportStart.
     *
     * @return mixed
     */
    public function getSupportStart()
    {
        return $this->supportStart;
    }

    /**
     * Sets the $supportStart.
     *
     * @param mixed $supportStart the support start
     *
     * @return self
     */
    public function setSupportStart($supportStart)
    {
        $this->supportStart = $supportStart;

        return $this;
    }

    /**
     * Gets the supportEnd.
     *
     * @return mixed
     */
    public function getSupportEnd()
    {
        return $this->supportEnd;
    }

    /**
     * Sets the $supportEnd.
     *
     * @param mixed $supportEnd the support end
     *
     * @return self
     */
    public function setSupportEnd($supportEnd)
    {
        $this->supportEnd = $supportEnd;

        return $this;
    }

    /**
     * Gets the description.
     *
     * @return mixed
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Sets the $description.
     *
     * @param mixed $description the description
     *
     * @return self
     */
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }

    /**
     * Gets the created.
     *
     * @return mixed
     */
    public function getCreated()
    {
        return $this->created;
    }

    /**
     * Sets the $created.
     *
     * @param mixed $created the created
     *
     * @return self
     */
    public function setCreated($created)
    {
        $this->created = $created;

        return $this;
    }

    /**
     * Gets the modified.
     *
     * @return mixed
     */
    public function getModified()
    {
        return $this->modified;
    }

    /**
     * Sets the $modified.
     *
     * @param mixed $modified the modified
     *
     * @return self
     */
    public function setModified($modified)
    {
        $this->modified = $modified;

        return $this;
    }
}
