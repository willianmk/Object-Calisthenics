<?php

class Cms_Model_CmsTest extends PHPUnit_Extensions_Database_TestCase
{
    /**
     * @var Cms_Model_Cms
     */
    private $model;

    protected function getConnection()
    {
        return $this->createDefaultDBConnection(Zend_Db_Table::getDefaultAdapter()->getConnection());
    }

    public function setUp()
    {
        $adapter = Zend_Db_Table::getDefaultAdapter();
        $adapter->exec('SET FOREIGN_KEY_CHECKS=0');
        parent::setUp();
        $adapter->exec('SET FOREIGN_KEY_CHECKS=1');

        $this->model = new Cms_Model_Cms();
    }

    /**
     * Asserts that the difference between two DateTime objects is almost equals by a tolerance margin.
     *
     * @param DateTime|string $expected   A DateTime object or a date/time string.
     * @param DateTime|string $actual     A DateTime object or a date/time string.
     * @param int             $tolerance  The tolerance in seconds. Defaults to 1 second.
     * @param string          $message
     *
     * @see http://www.php.net/manual/en/datetime.formats.php Supported Date and Time string formats.
     */
    static public function assertDateTimeAlmostEquals($expected, $actual, $tolerance = 2, $message = '')
    {
        if (!is_string($expected) && !$expected instanceof DateTime) {
            throw PHPUnit_Util_InvalidArgumentHelper::factory(1, 'string or a DateTime object');
        }

        if (!is_string($actual) && !$actual instanceof DateTime) {
            throw PHPUnit_Util_InvalidArgumentHelper::factory(2, 'string or a DateTime object');
        }

        if (is_string($expected)) {
            $expected = new DateTime($expected);
        }

        if (is_string($actual)) {
            $actual = new DateTime($actual);
        }

        // The differences are always positive numbers in the date/time properties of DateInterval.
        $difference = $expected->diff($actual)->s;

        self::assertLessThanOrEqual($tolerance, $difference, $message);
    }

    protected function getDataSet()
    {
        return $this->createXMLDataSet(__DIR__ . '/../fixtures/cms_active_folder.xml');
    }

    public function testShouldReturnSelectDefaultParameters()
    {
        $store = new Cms_Model_Store(1);

        $expectedResult = array(array(
            'id_cms_folder' => "1",
            'key' => "homepage",
            'label' => "Homepage",
            'revision' => "1",
            'created_at' => "2012-04-04 11:23:53"
        ));

        $result = Zend_Db_Table_Abstract::getDefaultAdapter()->query($this->model->getActiveFoldersSelect($store))->fetchAll();

        $this->assertEquals($expectedResult, $result);
    }

    public function testShouldReturnSelectConfirmed()
    {
        $store = 1;
        $drafts = true;
        $expectedResult = array(array(
            'id_cms_folder' => "2",
            'key' => "homepage",
            'label' => "Homepage",
            'revision' => "1",
            'created_at' => "2012-04-04 11:23:53"
        ));

        $result = Zend_Db_Table_Abstract::getDefaultAdapter()->query($this->model->getActiveFoldersSelect($store, $drafts))->fetchAll();

        $this->assertEquals($expectedResult, $result);
    }

    public function testShouldReturnSelectShopIdNotDefault()
    {
        $store = 1;
        $drafts = true;
        $shopId = 5;
        $expectedResult = array(array(
            'id_cms_folder' => "3",
            'key' => "homepage",
            'label' => "Homepage",
            'revision' => "1",
            'created_at' => "2012-04-04 11:23:53"
        ));

        $result = Zend_Db_Table_Abstract::getDefaultAdapter()->query($this->model->getActiveFoldersSelect($store, $drafts, $shopId))->fetchAll();

        $this->assertEquals($expectedResult, $result);
    }

    public function testShouldReturnSelectStore()
    {
        $store = 2;
        $drafts = true;
        $shopId = 5;
        $expectedResult = array(array(
            'id_cms_folder' => "5",
            'key' => "homepage",
            'label' => "Homepage",
            'revision' => "11",
            'created_at' => "2012-04-04 11:23:53"
        ));

        $result = Zend_Db_Table_Abstract::getDefaultAdapter()->query($this->model->getActiveFoldersSelect($store, $drafts, $shopId))->fetchAll();

        $this->assertEquals($expectedResult, $result);
    }

    public function testCannotReturnResult()
    {
        $store = 3;
        $drafts = true;
        $shopId = 5;
        $expectedResult = array();

        $result = Zend_Db_Table_Abstract::getDefaultAdapter()->query($this->model->getActiveFoldersSelect($store, $drafts, $shopId))->fetchAll();

        $this->assertEquals($expectedResult, $result);
    }

    /**
     * @dataProvider providerShopAndStoreIds
     */
    public function testShouldGetFoldersByKey($shopId, $storeId)
    {
        $expectedResult = array (
              0 =>
              array (
                'id_cms_folder' => '1',
                'fk_cms_folder_type' => '1',
                'fk_acl_user' => '1',
                'key' => 'homepage',
                'description' => 'description',
                'is_active' => '1',
                'revision' => '1',
                'created_at' => '2012-04-04 11:23:53',
                'is_confirmed' => '1',
                'fk_cms_shop' => '1',
                'fk_store_store' => '1',
              ),
              1 =>
              array (
                'id_cms_folder' => '2',
                'fk_cms_folder_type' => '1',
                'fk_acl_user' => '1',
                'key' => 'homepage',
                'description' => 'description',
                'is_active' => '1',
                'revision' => '1',
                'created_at' => '2012-04-04 11:23:53',
                'is_confirmed' => '0',
                'fk_cms_shop' => '1',
                'fk_store_store' => '1',
            ),
        );

        $this->assertEquals($expectedResult, $this->model->getFoldersByKey('homepage', 1, false, false, false, $shopId, $storeId));
    }

    public function providerShopAndStoreIds()
    {
        return array(
            array(1, 1),
            array(null, null),
            array(0, 0),
            array('', ''),
        );
    }

    public function testShouldGetFoldersByKeyWithoutResult()
    {
        $shopId = 10;
        $storeId = 10;

        $expectedResult = array();

        $this->assertEquals($expectedResult, $this->model->getFoldersByKey('does_not_exist', 1, false, false, false, $shopId, $storeId));
    }

    public function testShouldGetFolderByKeyAndRevision()
    {
        $expected = array(
            'id_cms_folder' => 8,
            'fk_cms_folder_type' => 4,
            'fk_acl_user' => 1,
            'key' => 'google_analytics',
            'description' => '',
            'is_active' => 1,
            'revision' => 1,
            'created_at' => '2012-07-01 18:18:18',
            'is_confirmed' => 1,
            'fk_cms_shop' => 1,
            'fk_store_store' => 2,
            'items' => array(array(
                'id_cms_item' => 2,
                'fk_cms_folder' => 8,
                'fk_cms_item_type' => 8,
                'fk_acl_user' => 1,
                'content' => '{google_analytics:1}',
                'created_at' => '2012-07-07 18:18:18',
                ))
        );

        $this->assertEquals($expected, $this->model->getFolderByKeyAndRevision('google_analytics', 1, 2));
    }

    public function testGetFolderByKeyAndRevisionShouldReturnFalseWhenNotFound()
    {
        $this->assertFalse($this->model->getFolderByKeyAndRevision('google_analytics', 1, 1));
    }

    public function testShouldGetActiveFolders()
    {
        $store = new Cms_Model_Store(null);
        $activeFolders = $this->model->getActiveFolders($store);
        $expectedIds = array(1, 4, 8);
        $expectedFkStores = array(1, 2, 2);
        $resultIds = array();
        $resultFkStores = array();

        foreach ($activeFolders as $folder) {
            $resultIds[] = $folder->getId();
            $resultFkStores[] = $folder[DbTable_Cms_FolderRow::FK_STORE_STORE];
        }

        $this->assertEquals($expectedIds, $resultIds);
        $this->assertEquals($expectedFkStores, $resultFkStores);
    }

    public function testShouldGetActiveFoldersWithIdStore()
    {
        $store = new Cms_Model_Store(1);
        $activeFolders = $this->model->getActiveFolders($store);
        $expectedIds = array(1);
        $resultIds = array();

        foreach ($activeFolders as $folder) {
            $resultIds[] = $folder->getId();
        }

        $this->assertEquals($expectedIds, $resultIds);
    }

    /**
     * @dataProvider providerFolderIdsForEmptyResult
     * @param $folderId
     */
    public function testGetFolderByIdWithEmptyResult($folderId)
    {
        $folder = new Cms_Model_Folder($folderId);
        $result = $this->model->getFolderById($folder);
        $this->assertEmpty($result);
    }

    public function providerFolderIdsForEmptyResult(){
        return array(
            array(null),
            array(0),
            array(''),
            array('0'),
            array(999999999999999),
            array(0.0),
            array(00.0),
            array('test')
        );
    }

    public function testGetFolderByIdWithResults()
    {
        $expected = array(
            'id_cms_folder' => '1',
            'fk_cms_folder_type' => '1',
            'fk_acl_user' => '1',
            'key' => 'homepage',
            'description' => 'description',
            'is_active' => '1',
            'revision' => '1',
            'created_at' => '2012-04-04 11:23:53',
            'is_confirmed' => '1',
            'fk_cms_shop' => '1',
            'fk_store_store' => '1',
            'items' => array(
                array(
                    'id_cms_item' => '1',
                    'fk_cms_folder' => '1',
                    'fk_cms_item_type' => '1',
                    'fk_acl_user' => '1',
                    'content' => 'content',
                    'created_at' => '2012-04-04 11:23:53'
                )
            )
        );
        $folder = new Cms_Model_Folder(1);
        $result = $this->model->getFolderById($folder);

        $this->assertEquals($expected, $result);
    }

    /**
     * @dataProvider providerInvalidValuesForKeys
     * @param $key
     */
    public function testGetFolderByKeyWithEmptyResults($key)
    {
        $result = $this->model->getFolderByKey($key);
        $this->assertFalse($result);
    }

    public function providerInvalidValuesForKeys()
    {
        return array(
            array(''),
            array('956531321635131531')
        );
    }

    /**
     * @expectedException Zend_Db_Statement_Exception
     */
    public function testGetFolderByKeyShouldThrowException()
    {
        $this->model->getFolderByKey(null);
    }

    public function testGetFolderByKey()
    {
        $expected = array(
            'id_cms_folder' => '4',
            'fk_cms_folder_type' => '1',
            'fk_acl_user' => '1',
            'key' => 'homepage',
            'description' => 'description',
            'is_active' => '1',
            'revision' => '11',
            'created_at' => '2012-04-04 11:23:53',
            'is_confirmed' => '1',
            'fk_cms_shop' => '5',
            'fk_store_store' => '2',
        );

        $result = $this->model->getFolderByKey('homepage');
        $this->assertEquals($expected, $result);
    }

    /**
     * @dataProvider providerFolders
     * @var array $provider
     * @var string $expected
     */
    public function testBuildFolderKey($provider, $expected)
    {
        $result = $this->model->buildFolderKey($provider);
        $this->assertEquals($expected, $result);
    }

    public function providerFolders()
    {
        return array(
            array(
                array(
                    'id_cms_folder' => '4',
                    'fk_cms_folder_type' => '1',
                    'key' => 'homepage',
                    'description' => 'description1',
                ),
                'homepage'
            ),

            array(
                array(
                    'id_cms_folder' => '4',
                    'fk_cms_folder_type' => '2',
                    'key' => 'homepage',
                    'description' => 'description2',
                ),
                'homepage'
            ),

            array(
                array(
                    'id_cms_folder' => '4',
                    'fk_cms_folder_type' => '3',
                    'key' => 'homepage',
                    'description' => 'description3',
                ),
                'description3'
            ),

            array(
                array(
                    'id_cms_folder' => '4',
                    'fk_cms_folder_type' => '4',
                    'key' => 'key4',
                    'description' => 'description4',
                ),
                'key4'
            ),
        );
    }

}
