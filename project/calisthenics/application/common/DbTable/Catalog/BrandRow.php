<?php

/**
 * This file is generated automatically by the db-schema updater.
 *  !!!Do not touch!!!
 *
 *  @see Maintenance_Model_DbTableClassGenerator
 */
class DbTable_Catalog_BrandRow extends Bob_Db_Table_Row
{

    /**
     * @internal int(10) unsigned
     */
    const ID_CATALOG_BRAND = 'id_catalog_brand';

    /**
     * @internal enum('active','inactive','deleted')
     */
    const STATUS = 'status';

    /**
     * @internal varchar(255)
     */
    const NAME = 'name';

    /**
     * @internal varchar(255)
     */
    const NAME_EN = 'name_en';

    /**
     * @internal smallint(5) unsigned
     */
    const POSITION = 'position';

    /**
     * @internal varchar(255)
     */
    const URL_KEY = 'url_key';

    /**
     * @internal varchar(255)
     */
    const IMAGE_NAME = 'image_name';

    protected $_columnDescription = array(
        'id_catalog_brand' => '',
        'status' => '',
        'name' => '',
        'name_en' => '',
        'position' => '',
        'url_key' => '',
        'image_name' => ''
        );

    protected $_tableClass = 'DbTable_Catalog_BrandTable';


}

