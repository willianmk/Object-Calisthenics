<?php 

class CmsRepository
{
    function __construct()
    {
        $this->setFolderTable(new DbTable_Cms_FolderTable());
    }

    public function setFolderTable($folderTable)
    {
        $this->folderTable = $folderTable;
    }

    public function getFolderTable()
    {
        return $this->folderTable;
    }

	public function findFolderByKey($key)
	{
        $folderTable = $this->getFolderTable();
        $sql = $folderTable->select()
            ->where('cms_folder.key = ?', $key)
            ->order('revision DESC')
            ->limit(1, 0);
        $folder = $folderTable->fetchRow($sql);
	}
}