CKEDITOR.dialog.add("smiley",function(e){for(var t,n=e.config,i=e.lang.smiley,o=n.smiley_images,a=n.smiley_columns||8,r=function(n){var i=n.data.getTarget(),o=i.getName();if("a"==o)i=i.getChild(0);else if("img"!=o)return;var o=i.getAttribute("cke_src"),a=i.getAttribute("title"),i=e.document.createElement("img",{attributes:{src:o,"data-cke-saved-src":o,title:a,alt:a,width:i.$.width,height:i.$.height}});e.insertElement(i),t.hide(),n.data.preventDefault()},s=CKEDITOR.tools.addFunction(function(t,n){t=new CKEDITOR.dom.event(t),n=new CKEDITOR.dom.element(n);var i;i=t.getKeystroke();var o="rtl"==e.lang.dir;switch(i){case 38:(i=n.getParent().getParent().getPrevious())&&(i=i.getChild([n.getParent().getIndex(),0]),i.focus()),t.preventDefault();break;case 40:(i=n.getParent().getParent().getNext())&&(i=i.getChild([n.getParent().getIndex(),0]))&&i.focus(),t.preventDefault();break;case 32:r({data:t}),t.preventDefault();break;case o?37:39:(i=n.getParent().getNext())?(i=i.getChild(0),i.focus(),t.preventDefault(!0)):(i=n.getParent().getParent().getNext())&&((i=i.getChild([0,0]))&&i.focus(),t.preventDefault(!0));break;case o?39:37:(i=n.getParent().getPrevious())?(i=i.getChild(0),i.focus(),t.preventDefault(!0)):(i=n.getParent().getParent().getPrevious())&&(i=i.getLast().getChild(0),i.focus(),t.preventDefault(!0))}}),l=CKEDITOR.tools.getNextId()+"_smiley_emtions_label",l=['<div><span id="'+l+'" class="cke_voice_label">'+i.options+"</span>",'<table role="listbox" aria-labelledby="'+l+'" style="width:100%;height:100%;border-collapse:separate;" cellspacing="2" cellpadding="2"',CKEDITOR.env.ie&&CKEDITOR.env.quirks?' style="position:absolute;"':"","><tbody>"],c=o.length,i=0;i<c;i++){0===i%a&&l.push('<tr role="presentation">');var d="cke_smile_label_"+i+"_"+CKEDITOR.tools.getNextNumber();l.push('<td class="cke_dark_background cke_centered" style="vertical-align: middle;" role="presentation"><a href="javascript:void(0)" role="option"',' aria-posinset="'+(i+1)+'"',' aria-setsize="'+c+'"',' aria-labelledby="'+d+'"',' class="cke_smile cke_hand" tabindex="-1" onkeydown="CKEDITOR.tools.callFunction( ',s,', event, this );">','<img class="cke_hand" title="',n.smiley_descriptions[i],'" cke_src="',CKEDITOR.tools.htmlEncode(n.smiley_path+o[i]),'" alt="',n.smiley_descriptions[i],'"',' src="',CKEDITOR.tools.htmlEncode(n.smiley_path+o[i]),'"',CKEDITOR.env.ie?" onload=\"this.setAttribute('width', 2); this.removeAttribute('width');\" ":"",'><span id="'+d+'" class="cke_voice_label">'+n.smiley_descriptions[i]+"</span></a>","</td>"),i%a==a-1&&l.push("</tr>")}if(i<a-1){for(;i<a-1;i++)l.push("<td></td>");l.push("</tr>")}return l.push("</tbody></table></div>"),n={type:"html",id:"smileySelector",html:l.join(""),onLoad:function(e){t=e.sender},focus:function(){var e=this;setTimeout(function(){e.getElement().getElementsByTag("a").getItem(0).focus()},0)},onClick:r,style:"width: 100%; border-collapse: separate;"},{title:e.lang.smiley.title,minWidth:270,minHeight:120,contents:[{id:"tab1",label:"",title:"",expand:!0,padding:0,elements:[n]}],buttons:[CKEDITOR.dialog.cancelButton]}});