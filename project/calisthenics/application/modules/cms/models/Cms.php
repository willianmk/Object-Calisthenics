<?php

/**
 *
 * @package cms
 */
class Cms_Model_Cms
{

    /**
     * Returns the directory where cms images are stored (creat if not existing)
     * @return string directory name
     */
    static public function getCmsDirectory($parameter = false)
    {
        $bootstrap = Zend_Controller_Front::getInstance()->getParam('bootstrap');

        $option = $bootstrap->getOption('catalog');

        if (substr($option['image_directory'], -1, 1) != '/') {
            $option['image_directory'] .= '/';
        }

        if ($parameter === false) {
            $dir = $option['image_directory'] . 'cms/';
        } else {
            $dir = $option['image_directory'] . $parameter;
        }

        if (!is_dir($dir)) {
            mkdir($dir, 0777, true);
        }

        return $dir;
    }

    /**
     * Returns the base url for images and brands
     * @return string
     */
    static public function getBaseUrl()
    {
        $bootstrap = Zend_Controller_Front::getInstance()->getParam('bootstrap');
        $option = $bootstrap->getOption('catalog');

        if (substr($option['image_base_url'], -1, 1) != '/') {
            $option['image_base_url'] .= '/';
        }

        return $option['image_base_url'] . 'cms/';
    }

    /**
     * Returns the base url for images and brands without ending with cms
     * @return string
     */
    static public function getMediaHost()
    {
        $bootstrap = Zend_Controller_Front::getInstance()->getParam('bootstrap');
        $option = $bootstrap->getOption('catalog');

        if (substr($option['image_base_url'], -1, 1) != '/') {
            $option['image_base_url'] .= '/';
        }

        return $option['image_base_url'];
    }

    static public function getAliceUrl()
    {
        $bootstrap = Zend_Controller_Front::getInstance()->getParam('bootstrap');
        $option = $bootstrap->getOption('resources');

        if (!isset($option['frontController']['absoluteURLAlice'])) {
            die('Please define resources.frontController.absoluteURLAlice in your application.ini!');
        }

        return $option['frontController']['absoluteURLAlice'];
    }

    /**
     * Returns the folder with the given db id (=id_cms_folder) and all its items.
     *
     * @param int $id The id of the folder.
     * @return array|Bob_Api_Result_Failed_WithError
     * Either an error object or an array which holds the folders properties and items.
     */
    public function getFolderById($id)
    {
        $table = new DbTable_Cms_FolderTable();
        $folder = $table->find($id)->current();

        if (!$folder) {
            return array();
        }

        $folderArr = $folder->toArray();
        $folderArr['items'] = $folder->findDependentRowset('DbTable_Cms_ItemTable')->toArray();

        return $folderArr;
    }

    /**
     * Returns all active folders
     *
     * @return array|Bob_Api_Result_Failed_WithError
     * Either an error object or an array which holds the folders properties and items.
     */
    public function getActiveFolders($storeId = null)
    {
        $table = new DbTable_Cms_FolderTable();

        $select = $table->select()->where('cms_folder.is_active = 1')->where('cms_folder.is_confirmed = 1')
            ->order('fk_store_store');

        if (null !== $storeId) {
            $select->where('cms_folder.fk_store_store = ?', $storeId);
        }

        return $table->fetchAll($select);
    }

    /**
     * Returns select statment for all active folders to use in zend pagination
     * @param boolean $drafts Show entries containing drafts?
     * @param integer $shopId Specify ID of shop
     * @return $select //Zend_Db_Select
     */
    public function getActiveFoldersSelect($store, $drafts = false, $shopId = 1)
    {
        $table = new DbTable_Cms_FolderTable();
        $select = $table->getAdapter()->select();
        $selectedTables = array(
            'cms_folder.id_cms_folder',
            'cms_folder.key',
            'cms_folder_type.label',
            'cms_folder.revision',
            'cms_folder.created_at'
        );
        $select->from($table->getName(), $selectedTables)
            ->join('cms_folder_type', 'cms_folder.fk_cms_folder_type = cms_folder_type.id_cms_folder_type', null)
            ->where('cms_folder.is_active = ?', 1)->where('cms_folder.fk_store_store = ?', $store)
            ->where('cms_folder.fk_cms_shop = ?', $shopId)
            ->joinLeft('cms_item', 'cms_item.fk_cms_folder = cms_folder.id_cms_folder', null)->group('cms_folder.key');
        $conditionConfirmed = 1;

        if ($drafts) {
            $conditionConfirmed = 0;
        }

        $select->where('cms_folder.is_confirmed = ?', $conditionConfirmed);
        $select->order(DbTable_Cms_FolderRow::CREATED_AT . ' DESC');

        return $select;
    }

    /**
     * Gets Folders by combination of key and folderType
     * @todo make better db request
     *
     * @param string $key
     * @param int $folderType
     * @return array an array which holds the folders properties and items.
     */
    public function getFoldersByKey($key,
            $folderType,
            $withItems = false,
            $withHistory = false,
            $useTypeNames = false,
            $shopId = null,
            $storeId = null)
    {
        $table = new DbTable_Cms_FolderTable();
        $select = $table->select();

        if (!$shopId) {
            $shopId = 1;
        }
        if (!$storeId) {
            $storeId = 1;
        }

        $select->where('cms_folder.key = ?', $key)->where('cms_folder.fk_store_store = ?', $storeId)
            ->where('cms_folder.' . DbTable_Cms_FolderRow::FK_CMS_SHOP . ' = ?', $shopId)->order('created_at DESC');

        if (!$withHistory) {
            $select->where('is_active = ?', 1);
        }

        $folders = $table->fetchAll($select);

        return (empty($folders)) ? array() : $folders->toArray();
    }

    /**
     * Gets Folders by combination of key and revision
     *
     * @param string $key
     * @param int $revision
     * @return array an array which holds the folders properties and items.
     */
    public function getFolderByKeyAndRevision($key, $revision, $storeId = 1)
    {
        $table = new DbTable_Cms_FolderTable();

        $sql = $table->select()
            ->where('cms_folder.key = ?', $key)
            ->where('cms_folder.revision = ?', $revision)
            ->where('cms_folder.fk_store_store = ?', $storeId);
        $folder = $table->fetchRow($sql);

        if (count($folder)) {
            $folderArr = $folder->toArray();
            $folderArr['items'] = $folder->findDependentRowset('DbTable_Cms_ItemTable')->toArray();
            return $folderArr;

        } else {
            return false;
        }
    }

    /**
     * Gets Folder by key
     *
     * @param string $key
     * @return array an array which holds the folders properties and items.
     */
    public function getFolderByKey($key)
    {
        $table = new DbTable_Cms_FolderTable();

        $sql = $table->select()->where('cms_folder.key = ?', $key)->order('revision DESC')->limit(1, 0);
        $folder = $table->fetchRow($sql);

        if (count($folder)) {
            $folderArr = $folder->toArray();
            return $folderArr;

        } else {
            return false;
        }
    }

    /**
     * Gets all Values for a specific Attribute by Attribute-ID (e.g. brand -> adidas,nike,...)
     *
     * @return array
     */
    public function getAttributes()
    {
        $resultArray = array();
        $table = new DbTable_Catalog_AttributeTable();
        $select = $table->select()->order('label ASC');
        $select->where(DbTable_Catalog_AttributeRow::SOLR_FILTER . ' IS NOT NULL');
        $select->where(DbTable_Catalog_AttributeRow::ATTRIBUTE_TYPE . ' in ("option","multi_option")');
        $select->group(DbTable_Catalog_AttributeRow::NAME);

        $rows = $table->fetchAllToArray($select);

        foreach ($rows as $row) {
            $resultArray[] = array(
                'id'    => $row[DbTable_Catalog_AttributeRow::ID_CATALOG_ATTRIBUTE],
                'name'  => $row[DbTable_Catalog_AttributeRow::NAME],
                'label' => $row[DbTable_Catalog_AttributeRow::LABEL]
            );
        }

        return $resultArray;
    }

    /**
     * Build CMS folder key based on folder settings
     *
     * @param array $data
     * @return string
     */
    public function buildFolderKey($data)
    {
        // TODO: implement missing folderTypes
        // TODO: use strings from folder type table
        $folderType = $data[DbTable_Cms_FolderRow::FK_CMS_FOLDER_TYPE];

        $key = null;

        switch ($folderType) {
            case 1:
                // home page
                $key = 'homepage';
                break;

            case 3:
                // catalog listing page
                $key = $this->_buildFolderKeyForCatalog($data);
                break;

            default:
                $key = strtolower($data[DbTable_Cms_FolderRow::KEY]);
                break;
        }

        $key = strtr(Utils_Translit::t($key), " ", "_");

        return $key;
    }

    /**
     * Building key for catalog-listing-page from attribute/category combination
     *
     * @param array $data
     * @return string
     */
    protected function _buildFolderKeyForCatalog($data)
    {
        $key = '';
        $brand = '';
        $category = '';
        $attributes = array();

        foreach ($data as $inputKey => $value) {
            $parts = explode('_', $inputKey);

            if (count($parts) > 0 && 'attr' == $parts[0]) {
                $attributes[$value] = $data['attrVal_' . $parts[1]];

            } elseif (count($parts) > 0 && 'cat' == $parts[0]) {
                $category = str_replace(" ", "_", $value);

            } elseif (count($parts) > 0 && 'brand' == $parts[0]) {
                $brand = str_replace(" ", "_", $value);
            }
        }

        ksort($attributes);

        if (!empty($category)) {
            $key = 'category:' . $category;
        }

        if (!empty($brand)) {
            $key .= ($key == '') ? '' : '__';

            $key .= 'brand:' . $brand;
        }

        foreach ($attributes as $attrKey => $attrVal) {
            if (!empty($key)) {
                $key .= '__';
            }
            $key .= $attrKey . ':' . $attrVal;
        }

        return $key;
    }

    /**
     * Returns an Array with all available folder types
     *
     * @return array
     */
    public function getFolderTypes()
    {
        $folderTypeTable = new DbTable_Cms_Folder_TypeTable();
        $folderTypes = array();

        foreach ($folderTypeTable->fetchAll() as $folderType) {
            $folderTypes[$folderType[DbTable_Cms_Folder_TypeRow::ID_CMS_FOLDER_TYPE]] = $folderType->toArray();
        }

        return $folderTypes;
    }

    /**
     * Returns an Array with all available item types
     *
     * @return array
     */
    public function getItemTypes()
    {
        $itemTypeTable = new DbTable_Cms_Item_TypeTable();
        $itemTypes = array();

        foreach ($itemTypeTable->fetchAll() as $itemType) {
            $itemTypes[$itemType[DbTable_Cms_Item_TypeRow::ID_CMS_ITEM_TYPE]] = $itemType->toArray();
        }

        return $itemTypes;
    }

    /**
     * Returns an Array with all PreSets for Folder-Item-Configuration (default fields on creating new)
     *
     * @return array
     */
    public function getFolderPresets()
    {
        $presets = array(
            1   => array(
                "foldertype"=> 1,
                "itemIds"   => array(1, 2, 3, 4, 5, 6, 8, 9)
            ),
            2   => array(
                "foldertype"=> 2,
                "itemIds"   => array(1, 2, 3, 4, 5, 6, 8, 9)
            ),
            //3   => array("foldertype"=>3, "itemIds"=>array(6)),
            //4   => array("foldertype"=>4, "itemIds"=>array(6)),
            //5   => array("foldertype"=>5, "itemIds"=>array(6)),
            3   => array(
                "foldertype"=> 3,
                "itemIds"   => array(1, 3, 4, 6)
            ),
            //7   => array("foldertype"=>7, "itemIds"=>array(6)),
            4   => array(
                "foldertype"=> 4,
                "itemIds"   => array(2)
            ),
            //9   => array("foldertype"=>9, "itemIds"=>array(6)),
            5   => array(
                "foldertype"=> 5,
                "itemIds"   => array(10)
            ),
            6   => array(
                "foldertype"=> 6,
                "itemIds"   => array(19, 20, 6, 18, 13, 16)
            ),
        );

        return $presets;
    }

    /**
     * Returns the JavaScript Configuration
     *
     * @return string Plain JavaScript Code
     */
    public function getConfig()
    {
        $js = "
            cms = {
                config : {
                    foldertypes : [],
                    folderpresets : [],
                    itemtypes : [],
                    xtypes : [],
                    form : []
                }
            };

            var CMS_FOLDER_HOMEPAGE = 1;
            var CMS_FOLDER_STATICPAGE = 2;
            //var CMS_FOLDER_LANDINGPAGE = 3;
            //var CMS_FOLDER_NORESULTPAGE = 4;
            //var CMS_FOLDER_SEARCHRESULT = 5;
            var CMS_FOLDER_CATALOGLISTING = 3;
            //var CMS_FOLDER_PRODUCTDETAIL = 7;
            var CMS_FOLDER_STATICBLOCK = 4;
            //var CMS_FOLDER_MAILTEMPLATE = 9;
            var CMS_FOLDER_BRANDSLIST = 5;
            var CMS_FOLDER_SHOPINSHOP = 6;

            window.bannerImageBaseUrl = '" . Cms_Model_Cms::getMediaHost() . "';
            window.aliceUrl = '" . Cms_Model_Cms::getAliceUrl() . "';
        ";

        $itemTypes = $this->getItemTypes();

        foreach ($itemTypes as $itemTypeId => $itemTypeData) {
            $js .= 'cms.config.itemtypes[' . $itemTypeId . '] = ' . Zend_Json::encode($itemTypeData) . ';' . "\n";
        }

        $folderTypes = $this->getFolderTypes();

        foreach ($folderTypes as $folderTypeId => $folderTypeData) {
            $js .= 'cms.config.foldertypes[' . $folderTypeId . '] = ' . Zend_Json::encode($folderTypeData) . ';' . "\n";
        }

        $folderPresets = $this->getFolderPresets();

        foreach ($folderPresets as $folderTypeId => $folderPresetData) {
            $js .=
            'cms.config.folderpresets[' . $folderTypeId . '] = ' . Zend_Json::encode($folderPresetData) . ';' . "\n";
        }

        return $js;
    }

    public function getUser()
    {
        $usersTable = new DbTable_Acl_UserTable();
        $selectedTables = array(
            DbTable_Acl_UserRow::ID_ACL_USER, DbTable_Acl_UserRow::USERNAME
        );
        $select = $usersTable->select();
        $select->from($usersTable, $selectedTables);

        $users = $usersTable->fetchAllToArray($select);
        $usersKeyValue = array();
        foreach ($users as $user) {
            $usersKeyValue[$user['id_acl_user']] = $user['username'];
        }

        return $usersKeyValue;
    }


    public function updateCatalogListingPageByBrand($oldBrand,$newBrand)
    {

        $db = Bob_Db_Table::getDefaultAdapter();
        $statement = $db->query("update cms_folder set `key` = replace(`key`, 'brand:".$oldBrand.
            "', 'brand:". $newBrand ."')
                    where `fk_cms_folder_type` =
                    (select `id_cms_folder_type` from `cms_folder_type` cft
                        where cft.`key` = 'cataloglisting' limit 0,1)
                        AND `key` like '%brand:". $oldBrand ."';");
        return true;
    }

    private function extractCmsBrandData(array $brands)
    {
        $return = array();

        foreach ($brands as $brand) {
            $return[] = array(
                DbTable_Catalog_BrandRow::ID_CATALOG_BRAND => $brand[DbTable_Catalog_BrandRow::ID_CATALOG_BRAND],
                DbTable_Catalog_BrandRow::NAME             => $brand[DbTable_Catalog_BrandRow::NAME]
            );
        }
        return $return;
    }
}
