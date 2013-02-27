<?php
/**
 * @package cms
 */
class Cms_Bootstrap extends Zend_Application_Module_Bootstrap
{
    protected function _initAutoload()
    {
        $this->getResourceLoader()
            ->addResourceType('api', 'apis/', 'Api')
            ->addResourceType('command', 'commands/', 'Command')
            ->addResourceType('migration', 'migrations/', 'Migration');
    }
}
