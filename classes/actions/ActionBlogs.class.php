<?php
/*-------------------------------------------------------
*
*   LiveStreet Engine Social Networking
*   Copyright © 2008 Mzhelskiy Maxim
*
*--------------------------------------------------------
*
*   Official site: www.livestreet.ru
*   Contact e-mail: rus.engine@gmail.com
*
*   GNU General Public License, version 2:
*   http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
*
---------------------------------------------------------
*/

/**
 * Класс обработки УРЛа вида /comments/
 *
 */
class ActionBlogs extends Action {	
	
	public function Init() {		
		/**
		 * Загружаем в шаблон JS текстовки
		 */
		$this->Lang_AddLangJs(array(
			'blog_join','blog_leave'
		));
	}
	
	protected function RegisterEvent() {	
		$this->AddEventPreg('/^(page(\d+))?$/i','EventShowBlogs');
		$this->AddEventPreg('/^ajax-search$/i','EventAjaxSearch');
	}
		
	
	/**********************************************************************************
	 ************************ РЕАЛИЗАЦИЯ ЭКШЕНА ***************************************
	 **********************************************************************************
	 */	

	/**
	 * Поиск блогов
	 */
	protected function EventAjaxSearch() {
		$this->Viewer_SetResponseAjax('json');

		if ($sTitle=getRequest('blog_title') and is_string($sTitle)) {
			$sTitle=str_replace('%','',$sTitle);
		}
		if (!$sTitle) {
			$this->Message_AddErrorSingle($this->Lang_Get('system_error'));
			return;
		}

		$aResult=$this->Blog_GetBlogsByFilter(array('exclude_type' => 'personal','title'=>"%{$sTitle}%"),array('blog_title'=>'asc'),1,100);

		$oViewer=$this->Viewer_GetLocalViewer();
		$oViewer->Assign('aBlogs',$aResult['collection']);
		$oViewer->Assign('sBlogsEmptyList',$this->Lang_Get('blogs_search_empty'));
		$this->Viewer_AssignAjax('sText',$oViewer->Fetch("blog_list.tpl"));
	}
	
	protected function EventShowBlogs() {
		/**
		 * По какому полю сортировать
		 */
		$sOrder='blog_rating';
		if (getRequest('order')) {
			$sOrder=getRequest('order');
		}
		/**
		 * В каком направлении сортировать
		 */
		$sOrderWay='desc';
		if (getRequest('order_way')) {
			$sOrderWay=getRequest('order_way');
		}
		$aFilter=array(
			'exclude_type' => 'personal'
		);

		/**
		 * Передан ли номер страницы
		 */			
		$iPage=	preg_match("/^\d+$/i",$this->GetEventMatch(2)) ? $this->GetEventMatch(2) : 1;
		/**
		 * Получаем список блогов
		 */

		$aResult=$this->Blog_GetBlogsByFilter($aFilter,array($sOrder=>$sOrderWay),$iPage,Config::Get('module.blog.per_page'));
		$aBlogs=$aResult['collection'];				
		/**
		 * Формируем постраничность
		 */		
		$aPaging=$this->Viewer_MakePaging($aResult['count'],$iPage,Config::Get('module.blog.per_page'),4,Router::GetPath('blogs'),array('order'=>$sOrder,'order_way'=>$sOrderWay));
		/**
		 * Загружаем переменные в шаблон
		 */					
		$this->Viewer_Assign('aPaging',$aPaging);					
		$this->Viewer_Assign("aBlogs",$aBlogs);
		$this->Viewer_Assign("sBlogOrder",htmlspecialchars($sOrder));
		$this->Viewer_Assign("sBlogOrderWay",htmlspecialchars($sOrderWay));
		$this->Viewer_Assign("sBlogOrderWayNext",htmlspecialchars($sOrderWay=='desc' ? 'asc' : 'desc'));
		$this->Viewer_AddHtmlTitle($this->Lang_Get('blog_menu_all_list'));
		/**
		 * Устанавливаем шаблон вывода
		 */
		$this->SetTemplateAction('index');				
	}
}
?>