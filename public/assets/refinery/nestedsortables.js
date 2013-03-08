/*
 * jQuery UI Nested Sortable
 * v 1.3.4 / 28 apr 2011
 * http://mjsarfatti.com/sandbox/nestedSortable
 *
 * Depends:
 *   jquery.ui.sortable.js 1.8+
 *
 * License CC BY-SA 3.0
 * Copyright 2010-2011, Manuele J Sarfatti
 */
(function(e){e.widget("ui.nestedSortable",e.extend({},e.ui.sortable.prototype,{options:{tabSize:20,disableNesting:"ui-nestedSortable-no-nesting",errorClass:"ui-nestedSortable-error",listType:"ol",maxLevels:0,noJumpFix:0},_create:function(){return this.noJumpFix==0&&this.element.height(this.element.height()),this.element.data("sortable",this.element.data("nestedSortable")),e.ui.sortable.prototype._create.apply(this,arguments)},_mouseDrag:function(t){this.position=this._generatePosition(t),this.positionAbs=this._convertPositionTo("absolute"),this.lastPositionAbs||(this.lastPositionAbs=this.positionAbs);if(this.options.scroll){var n=this.options,r=!1;this.scrollParent[0]!=document&&this.scrollParent[0].tagName!="HTML"?(this.overflowOffset.top+this.scrollParent[0].offsetHeight-t.pageY<n.scrollSensitivity?this.scrollParent[0].scrollTop=r=this.scrollParent[0].scrollTop+n.scrollSpeed:t.pageY-this.overflowOffset.top<n.scrollSensitivity&&(this.scrollParent[0].scrollTop=r=this.scrollParent[0].scrollTop-n.scrollSpeed),this.overflowOffset.left+this.scrollParent[0].offsetWidth-t.pageX<n.scrollSensitivity?this.scrollParent[0].scrollLeft=r=this.scrollParent[0].scrollLeft+n.scrollSpeed:t.pageX-this.overflowOffset.left<n.scrollSensitivity&&(this.scrollParent[0].scrollLeft=r=this.scrollParent[0].scrollLeft-n.scrollSpeed)):(t.pageY-e(document).scrollTop()<n.scrollSensitivity?r=e(document).scrollTop(e(document).scrollTop()-n.scrollSpeed):e(window).height()-(t.pageY-e(document).scrollTop())<n.scrollSensitivity&&(r=e(document).scrollTop(e(document).scrollTop()+n.scrollSpeed)),t.pageX-e(document).scrollLeft()<n.scrollSensitivity?r=e(document).scrollLeft(e(document).scrollLeft()-n.scrollSpeed):e(window).width()-(t.pageX-e(document).scrollLeft())<n.scrollSensitivity&&(r=e(document).scrollLeft(e(document).scrollLeft()+n.scrollSpeed))),r!==!1&&e.ui.ddmanager&&!n.dropBehaviour&&e.ui.ddmanager.prepareOffsets(this,t)}this.positionAbs=this._convertPositionTo("absolute");if(!this.options.axis||this.options.axis!="y")this.helper[0].style.left=this.position.left+"px";if(!this.options.axis||this.options.axis!="x")this.helper[0].style.top=this.position.top+"px";for(var i=this.items.length-1;i>=0;i--){var s=this.items[i],o=s.item[0],u=this._intersectsWithPointer(s);if(!u)continue;if(o!=this.currentItem[0]&&this.placeholder[u==1?"next":"prev"]()[0]!=o&&!e.contains(this.placeholder[0],o)&&(this.options.type=="semi-dynamic"?!e.contains(this.element[0],o):!0)){this.direction=u==1?"down":"up";if(this.options.tolerance!="pointer"&&!this._intersectsWithSides(s))break;this._rearrange(t,s),this._clearEmpty(o),this._trigger("change",t,this._uiHash());break}}var a=this.placeholder[0].parentNode.parentNode&&e(this.placeholder[0].parentNode.parentNode).closest(".ui-sortable").length?e(this.placeholder[0].parentNode.parentNode):null,f=this._getLevel(this.placeholder),l=this._getChildLevels(this.helper),c=this.placeholder[0].previousSibling?e(this.placeholder[0].previousSibling):null;if(c!=null)while(c[0].nodeName.toLowerCase()!="li"||c[0]==this.currentItem[0]){if(!c[0].previousSibling){c=null;break}c=e(c[0].previousSibling)}return newList=document.createElement(n.listType),this.beyondMaxLevels=0,a!=null&&this.positionAbs.left<a.offset().left?(a.after(this.placeholder[0]),this._clearEmpty(a[0]),this._trigger("change",t,this._uiHash())):c!=null&&this.positionAbs.left>c.offset().left+n.tabSize?(this._isAllowed(c,f+l+1),c.children(n.listType).length||c[0].appendChild(newList),c.children(n.listType)[0].appendChild(this.placeholder[0]),this._trigger("change",t,this._uiHash())):this._isAllowed(a,f+l),this._contactContainers(t),e.ui.ddmanager&&e.ui.ddmanager.drag(this,t),this._trigger("sort",t,this._uiHash()),this.lastPositionAbs=this.positionAbs,!1},_mouseStop:function(t,n){if(this.beyondMaxLevels){var r=this.placeholder.parent().closest(this.options.items);for(var i=this.beyondMaxLevels-1;i>0;i--)r=r.parent().closest(this.options.items);this.placeholder.removeClass(this.options.errorClass),r.after(this.placeholder),this._trigger("change",t,this._uiHash())}e.ui.sortable.prototype._mouseStop.apply(this,arguments)},serialize:function(t){var n=this._getItemsAsjQuery(t&&t.connected),r=[];return t=t||{},e(n).each(function(){var n=(e(t.item||this).attr(t.attribute||"id")||"").match(t.expression||/(.+)[-=_](.+)/),i=(e(t.item||this).parent(t.listType).parent("li").attr(t.attribute||"id")||"").match(t.expression||/(.+)[-=_](.+)/);n&&r.push((t.key||n[1]+"["+(t.key&&t.expression?n[1]:n[2])+"]")+"="+(i?t.key&&t.expression?i[1]:i[2]:"root"))}),!r.length&&t.key&&r.push(t.key+"="),r.join("&")},toHierarchy:function(t){function i(n){var r=(e(n).attr(t.attribute||"id")||"").match(t.expression||/(.+)[-=_](.+)/);if(r!=null){var s={id:r[2]};return e(n).children(t.listType).children("li").length>0&&(s.children=[],e(n).children(t.listType).children("li").each(function(){var t=i(e(this));s.children.push(t)})),s}}t=t||{};var n=t.startDepthCount||0,r=[];return e(this.element).children("li").each(function(){var t=i(e(this));r.push(t)}),r},toArray:function(t){function s(e,t){return e.left-t.left}function o(i,s,u){return right=u+1,e(i).children(t.listType).children("li").length>0&&(s++,e(i).children(t.listType).children("li").each(function(){right=o(e(this),s,right)}),s--),id=e(i).attr(t.attribute||"id").match(t.expression||/(.+)[-=_](.+)/),s===n+1?pid="root":(parentItem=e(i).parent(t.listType).parent("li").attr("id").match(t.expression||/(.+)[-=_](.+)/),pid=parentItem[2]),id!=null&&r.push({item_id:id[2],parent_id:pid,depth:s,left:u,right:right}),u=right+1}t=t||{};var n=t.startDepthCount||0,r=[],i=2;return r.push({item_id:"root",parent_id:"none",depth:n,left:"1",right:(e("li",this.element).length+1)*2}),e(this.element).children("li").each(function(){i=o(this,n+1,i)}),r=r.sort(s),r},_clear:function(t,n){e.ui.sortable.prototype._clear.apply(this,arguments);for(var r=this.items.length-1;r>=0;r--){var i=this.items[r].item[0];this._clearEmpty(i)}return!0},_clearEmpty:function(e){e.children[1]&&e.children[1].children.length==0&&e.removeChild(e.children[1])},_getLevel:function(e){var t=1;if(this.options.listType){var n=e.closest(this.options.listType);while(!n.is(".ui-sortable"))t++,n=n.parent().closest(this.options.listType)}return t},_getChildLevels:function(t,n){var r=this,i=this.options,s=0;return n=n||0,e(t).children(i.listType).children(i.items).each(function(e,t){s=Math.max(r._getChildLevels(t,n+1),s)}),n?s+1:s},_isAllowed:function(e,t){var n=this.options;e==null||!e.hasClass(n.disableNesting)?n.maxLevels<t&&n.maxLevels!=0?(this.placeholder.addClass(n.errorClass),this.beyondMaxLevels=t-n.maxLevels):(this.placeholder.removeClass(n.errorClass),this.beyondMaxLevels=0):(this.placeholder.addClass(n.errorClass),n.maxLevels<t&&n.maxLevels!=0?this.beyondMaxLevels=t-n.maxLevels:this.beyondMaxLevels=1)}})),e.ui.nestedSortable.prototype.options=e.extend({},e.ui.sortable.prototype.options,e.ui.nestedSortable.prototype.options)})(jQuery);